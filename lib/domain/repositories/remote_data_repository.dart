import 'dart:convert';

import '../../data/models/pokemon_item.dart';
import '../../data/remote_data_sources/interfaces/api_data_interface.dart';
import '../di/injector.dart';
import '../entities/pokemon.dart';
import 'interfaces/pokemon_data_interface.dart';

class RemoteDataRepository implements IRemoteDataRepository {
  final IRemoteDataProvider _remoteDataRepository =
      i.get<IRemoteDataProvider>();

  @override
  Future<Pokemon> getPokemonById(int pokemonId) async {
    final response = await _remoteDataRepository.getPokemonById(pokemonId);
    final body = json.decode(response.body);
    return Pokemon.fromApiMap(body);
  }

  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]) async {
    final resultList = <PokemonItem>[];

    final response = await _remoteDataRepository.getPokemonItems(startIndex);
    final body = json.decode(response.body) as Map;
    for (final pokemonDataMap in body['results']) {
      resultList.add(PokemonItem.fromMap(pokemonDataMap));
    }
    return resultList;
  }
}
