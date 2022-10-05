import 'dart:convert';

import 'package:pika_pika_test_project/features/pokemon_app/data/models/apiDtos/pokemon_api_dto.dart';
import 'package:pika_pika_test_project/features/pokemon_app/data/models/apiDtos/pokemon_item_api_dto.dart';

import '../../../../injector.dart';
import '../../domain/entities/pokemon_item.dart';
import 'interfaces/api_data_interface.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/interfaces/pokemon_data_interface.dart';

class RemoteDataRepository implements IRemoteDataRepository {
  final IRemoteDataProvider _remoteDataRepository =
      i.get<IRemoteDataProvider>();

  @override
  Future<Pokemon> getPokemonById(int pokemonId) async {
    final response = await _remoteDataRepository.getPokemonById(pokemonId);
    final body = json.decode(response.body);
    final PokemonApiDto pokemonApiDto = PokemonApiDto.fromApiMap(body);
    return Pokemon.fromApiDto(pokemonApiDto);
  }

  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]) async {
    final resultList = <PokemonItem>[];

    final response = await _remoteDataRepository.getPokemonItems(startIndex);
    final body = json.decode(response.body) as Map;
    for (final pokemonDataMap in body['results']) {
      final PokemonItemApiDto pokemonItemApiDto =
          PokemonItemApiDto.fromApiMap(pokemonDataMap);
      final PokemonItem pokemonItem = PokemonItem.fromApiDto(pokemonItemApiDto);
      resultList.add(pokemonItem);
    }
    return resultList;
  }
}
