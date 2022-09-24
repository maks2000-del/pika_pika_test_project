import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/pokemon_item.dart';
import '../pages/detailed_info/detailed_info_page.dart';

class PokemonListItem extends StatelessWidget {
  const PokemonListItem({Key? key, required this.pokemonItem})
      : super(key: key);

  final PokemonItem pokemonItem;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        child: ListTile(
          leading: Text(pokemonItem.urlId),
          title: Text(pokemonItem.name),
        ),
        onTap: () => Get.to(
          () => DetailedInfoPage(
            pokemonUrl: pokemonItem.urlId,
          ),
        ),
      ),
    );
  }
}
