import 'package:flutter/material.dart';

import '../../data/models/pokemon_item.dart';

class PokemonListItem extends StatelessWidget {
  const PokemonListItem({Key? key, required this.pokemonItem})
      : super(key: key);

  final PokemonItem pokemonItem;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text(pokemonItem.urlId, style: textTheme.caption),
        title: Text(pokemonItem.name),
      ),
    );
  }
}
