import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_pika_test_project/presentation/pages/main/bloc/home_bloc.dart';

import '../../../di/injector.dart';
import '../../app/app_themes.dart';
import 'pokemos_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Pokemons')),
        backgroundColor: darkTheme.secondaryBackgroundColor,
      ),
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              return BlocProvider(
                create: (_) => i.get<HomeBloc>(),
                child: const PokemonsList(),
              );
            }
          }
          return Container(
            color: darkTheme.secondaryBackgroundColor,
          );
        },
        future: initInjector(),
      ),
    );
  }
}
