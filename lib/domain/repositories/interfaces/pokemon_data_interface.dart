import 'package:pika_pika_test_project/data/models/pokemon_item.dart';

import '../../entities/pokemon.dart';
import '../cash_data_repository.dart';

abstract class IDataRepository {
  Future<Pokemon> getPokemonById(String pokemonId);
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]);
}

abstract class IRemoteDataRepository implements IDataRepository {
  @override
  Future<Pokemon> getPokemonById(String pokemonId);
  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]);
}

abstract class ILocalDataRepository implements IDataRepository {
  @override
  Future<Pokemon> getPokemonById(String pokemonId);
  Future<CashingStatus> savePokemonById(String pokemonId, Pokemon pokemon);

  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]);
  Future<CashingStatus> savePokemonItems(List<PokemonItem> items);
}
