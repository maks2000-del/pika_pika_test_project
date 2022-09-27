import 'package:pika_pika_test_project/data/models/pokemon_item.dart';

import '../../entities/pokemon.dart';

abstract class IRemoteDataRepository {
  Future<Pokemon> getPokemonById(String pokemonId);
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]);
}
