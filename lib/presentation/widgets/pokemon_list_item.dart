import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pika_pika_test_project/presentation/pages/detailed_info/bloc/detailed_info_bloc.dart';

import '../../data/models/pokemon_item.dart';
import '../app/app_themes.dart';
import '../di/injector.dart';
import '../pages/detailed_info/detailed_info_page.dart';
import '../utils/string_formatter.dart';

class PokemonListItem extends StatelessWidget {
  const PokemonListItem({Key? key, required this.pokemonItem})
      : super(key: key);

  final PokemonItem pokemonItem;

  @override
  Widget build(BuildContext context) {
    final id = StringFormatter.consvertUrlToId(pokemonItem.urlId);

    return Material(
      child: GestureDetector(
        child: ListTile(
          tileColor: darkTheme.primaryBackgroundColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              id,
              style: TextStyle(
                color: darkTheme.textColor,
                letterSpacing: 1.0,
              ),
            ),
          ),
          title: Text(
            pokemonItem.name,
            style: TextStyle(
              color: darkTheme.actionColor,
              letterSpacing: 1.0,
            ),
          ),
        ),
        onTap: () {
          DetailedInfoBloc _detailedInfoBloc = i.get<DetailedInfoBloc>()
            ..add(PockemonPicked(id));
          Get.to(
            () => DetailedInfoPage(
              detailedInfoBloc: _detailedInfoBloc,
            ),
          );
        },
      ),
    );
  }
}
