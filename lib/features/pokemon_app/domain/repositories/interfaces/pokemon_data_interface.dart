import '../../entities/pokemon.dart';
import '../../entities/pokemon_item.dart';
import '../cash_data_repository.dart';

abstract class IDataRepository {
  Future<Pokemon> getPokemonById(int pokemonId);
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]);
}

abstract class IRemoteDataRepository implements IDataRepository {
  @override
  Future<Pokemon> getPokemonById(int pokemonId);
  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]);
}

abstract class ILocalDataRepository implements IDataRepository {
  @override
  Future<Pokemon> getPokemonById(int pokemonId);
  Future<CashingStatus> savePokemonById(int pokemonId, Pokemon pokemon);

  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]);
  Future<CashingStatus> savePokemonItems(List<PokemonItem> items);
}
