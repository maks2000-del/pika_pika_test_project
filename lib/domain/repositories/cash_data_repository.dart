import 'package:pika_pika_test_project/data/local_data_source/local_data_source.dart';
import 'package:pika_pika_test_project/domain/entities/pokemon.dart';
import 'package:pika_pika_test_project/data/models/pokemon_item.dart';
import 'package:pika_pika_test_project/domain/repositories/interfaces/pokemon_data_interface.dart';

import '../../presentation/di/injector.dart';

enum CashingStatus { success, failure }

class CashDataRepository implements ILocalDataRepository {
  final _sQliteEntityDataSource = i.get<SQliteEntityDataSource>();
  final _sQliteEntitiesDataSource = i.get<SQliteEntitiesDataSource>();
  CashDataRepository();

  @override
  Future<Pokemon> getPokemonById(String pokemonId) async {
    final entitie = await _sQliteEntityDataSource.getEntityById(pokemonId);
    return Pokemon.fromDBMap(entitie);
  }

  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]) async {
    final pokemonItems = <PokemonItem>[];
    final dbPokemonItems = await _sQliteEntitiesDataSource.getEntities();
    for (final item in dbPokemonItems) {
      var pokemonItem = PokemonItem.fromMap(item as Map<String, dynamic>);
      pokemonItems.add(pokemonItem);
    }
    return pokemonItems;
  }

  @override
  Future<CashingStatus> savePokemonById(
      String pokemonId, Pokemon pokemon) async {
    final entitie = pokemon.toDBMap();
    final cashingStatus =
        await _sQliteEntityDataSource.saveEntityById(pokemonId, entitie);
    return cashingStatus;
  }

  @override
  Future<CashingStatus> savePokemonItems(List<PokemonItem> items) async {
    final entities = <Map<String, dynamic>>[];

    for (final item in items) {
      var pokemonEntitie = item.toDBMap();
      entities.add(pokemonEntitie);
    }
    final status = await _sQliteEntitiesDataSource.saveEntities(entities);
    return status;
  }
}
