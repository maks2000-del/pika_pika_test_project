import 'package:pika_pika_test_project/data/local_data_source/local_data_source.dart';
import 'package:pika_pika_test_project/domain/entities/pokemon.dart';
import 'package:pika_pika_test_project/data/models/pokemon_item.dart';
import 'package:pika_pika_test_project/domain/repositories/interfaces/pokemon_data_interface.dart';
import 'package:sqflite/sqflite.dart';

import '../../presentation/di/injector.dart';
import '../../presentation/utils/sqlite_open_helper.dart';

enum CashingStatus { success, failure }

class CashDataRepository implements ILocalDataRepository {
  CashDataRepository();

  @override
  Future<Pokemon> getPokemonById(int pokemonId) async {
    SqliteDataBaseOpenHelper sqliteDataBaseOpenHelper =
        SqliteDataBaseOpenHelper();
    Database database = await sqliteDataBaseOpenHelper.initDatabase();
    SQliteEntityDataSource sQliteEntitiesDataSource =
        SQliteEntityDataSource(database);
    final entitie = await sQliteEntitiesDataSource.getEntityById(pokemonId);

    Pokemon pokemonItem = Pokemon.fromDBMap(entitie[0] as Map<String, dynamic>);

    return pokemonItem;
  }

  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]) async {
    final pokemonItems = <PokemonItem>[];
    SqliteDataBaseOpenHelper sqliteDataBaseOpenHelper =
        SqliteDataBaseOpenHelper();
    Database database = await sqliteDataBaseOpenHelper.initDatabase();
    SQliteEntitiesDataSource sQliteEntitiesDataSource =
        SQliteEntitiesDataSource(database);

    final dbPokemonItems = await sQliteEntitiesDataSource.getEntities();

    for (final item in dbPokemonItems) {
      var pokemonItem = PokemonItem.fromMap(item as Map<String, dynamic>);
      pokemonItems.add(pokemonItem);
    }
    return pokemonItems;
  }

  @override
  Future<CashingStatus> savePokemonById(int pokemonId, Pokemon pokemon) async {
    final entitie = pokemon.toDBMap(pokemonId);

    final cashingStatus = await i
        .get<SQliteEntityDataSource>()
        .saveEntityById(pokemonId, entitie);

    return cashingStatus;
  }

  @override
  Future<CashingStatus> savePokemonItems(List<PokemonItem> items) async {
    final entities = <Map<String, dynamic>>[];

    for (final item in items) {
      var pokemonEntitie = item.toDBMap();
      entities.add(pokemonEntitie);
    }
    final status =
        await i.get<SQliteEntitiesDataSource>().saveEntities(entities);
    return status;
  }
}
