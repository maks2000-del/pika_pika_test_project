import 'package:flutter/material.dart';
import 'package:pika_pika_test_project/presentation/utils/context_extension.dart';

import 'pokemos_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Pokemons')),
          backgroundColor: context.theme.actionColor,
        ),
        body: const PokemonsList());
  }
}
