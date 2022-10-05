import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/bottom_loader.dart';
import '../../../../../core/widgets/loading_screen.dart';
import '../../../../../injector.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/interfaces/pokemon_data_interface.dart';
import '../../widgets/pokemon_list_item.dart';
import 'bloc/home_bloc.dart';

class PokemonsList extends StatefulWidget {
  const PokemonsList({Key? key}) : super(key: key);

  @override
  State<PokemonsList> createState() => _PokemonsListState();
}

class _PokemonsListState extends State<PokemonsList> {
  final _scrollController = ScrollController();
  late final _subscription;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      i.unregister<IDataRepository>();
      final IDataRepository dataRepository = (result != ConnectivityResult.none)
          ? i.get<IRemoteDataRepository>()
          : i.get<ILocalDataRepository>();

      i.registerFactory<IDataRepository>(
        () => DataReository(dataRepository),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchStatus.failure:
            return const Center(
              child: Text('failed to fetch data'),
            );
          case FetchStatus.success:
            if (state.pokemonItems.isEmpty) {
              return const Center(
                child: Text('no pokemons :c'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.pokemonItems.length
                    ? const BottomLoader()
                    : PokemonListItem(
                        key: Key(state.pokemonItems[index].id),
                        pokemonItem: state.pokemonItems[index],
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.pokemonItems.length
                  : state.pokemonItems.length + 1,
              controller: _scrollController,
            );
          case FetchStatus.initial:
            return const LoadingPage();
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _subscription.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<HomeBloc>().add(PokemonsFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
