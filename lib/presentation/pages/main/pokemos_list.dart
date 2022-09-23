import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_pika_test_project/presentation/widgets/pokemon_list_item.dart';

import '../../widgets/bottom_loader.dart';
import 'bloc/home_bloc.dart';

class PostsList extends StatefulWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchStatus.failure:
            return const Center(child: Text('failed to fetch data'));
          case FetchStatus.success:
            if (state.pokemonItems.isEmpty) {
              return const Center(child: Text('no pokemons :c'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.pokemonItems.length
                    ? const BottomLoader()
                    : PokemonListItem(pokemonItem: state.pokemonItems[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.pokemonItems.length
                  : state.pokemonItems.length + 1,
              controller: _scrollController,
            );
          case FetchStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<HomeBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
