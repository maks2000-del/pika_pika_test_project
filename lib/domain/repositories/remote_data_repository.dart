import 'dart:convert';

import 'package:pika_pika_test_project/data/models/pokemon_item.dart';
import 'package:pika_pika_test_project/data/remote_data_sources/api_data_source.dart';

import '../entities/pokemon.dart';
import 'interfaces/pokemon_data_interface.dart';

class RemoteDataRepository implements IRemoteDataRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  @override
  Future<Pokemon> getPokemonById(int pokemonId) async {
    final response = await remoteDataSource.getPokemonById(pokemonId);

    final body = json.decode(response.body);
    return Pokemon.fromApiMap(body);
  }

  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]) async {
    final response = await remoteDataSource.getPokemonItems(startIndex);

    final resultList = <PokemonItem>[];
    final body = json.decode(response.body) as Map;
    for (final pokemonDataMap in body['results']) {
      resultList.add(PokemonItem.fromMap(pokemonDataMap));
    }
    return resultList;
  }
}
