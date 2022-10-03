import '../../data/local_data_source/interfaces/i_local_data_source.dart';
import '../../data/models/pokemon_item.dart';
import '../di/injector.dart';
import '../entities/pokemon.dart';
import 'interfaces/pokemon_data_interface.dart';

enum CashingStatus { success, failure }

class CashDataRepository implements ILocalDataRepository {
  final ILocalDataSourceEntity _localDataProvider =
      i.get<ILocalDataSourceEntity>();

  @override
  Future<Pokemon> getPokemonById(int pokemonId) async {
    final entitie = await _localDataProvider.getEntityById(pokemonId);

    Pokemon pokemonItem = Pokemon.fromDBMap(entitie[0] as Map<String, dynamic>);
    return pokemonItem;
  }

  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]) async {
    final pokemonItems = <PokemonItem>[];
    final dbPokemonItems = await _localDataProvider.getEntities();

    for (final item in dbPokemonItems) {
      var pokemonItem = PokemonItem.fromMap(item as Map<String, dynamic>);
      pokemonItems.add(pokemonItem);
    }
    return pokemonItems;
  }

  @override
  Future<CashingStatus> savePokemonById(int pokemonId, Pokemon pokemon) async {
    final entitie = pokemon.toDBMap(pokemonId);

    final cashingStatus =
        await _localDataProvider.saveEntityById(pokemonId, entitie);
    return cashingStatus;
  }

  @override
  Future<CashingStatus> savePokemonItems(List<PokemonItem> items) async {
    final entities = <Map<String, dynamic>>[];

    for (final item in items) {
      var pokemonEntitie = item.toDBMap();
      entities.add(pokemonEntitie);
    }
    final status = await _localDataProvider.saveEntities(entities);
    return status;
  }
}
