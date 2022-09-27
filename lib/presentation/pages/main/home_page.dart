import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_pika_test_project/presentation/pages/main/bloc/home_bloc.dart';

import '../../app/app_themes.dart';
import '../../di/injector.dart';
import 'pokemos_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc _homeBlock = i.get<HomeBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Pokemons')),
        backgroundColor: darkTheme.secondaryBackgroundColor,
      ),
      body: BlocProvider(
        create: (_) => _homeBlock,
        child: const PokemonsList(),
      ),
    );
  }
}
