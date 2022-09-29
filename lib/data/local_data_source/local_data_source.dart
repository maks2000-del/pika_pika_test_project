import 'package:sqflite/sqflite.dart';
import '../../domain/repositories/cash_data_repository.dart';
import '../../presentation/utils/sqlite_open_helper.dart';
import 'interfaces/i_local_data_source.dart';

class SQliteEntityDataSource implements ILocalDataSourceEntity {
  late final Database database;

  SQliteEntityDataSource(this.database);

  @override
  Future<dynamic> getEntityById(int id) async {
    try {
      final dbEntity = await database.rawQuery(
        'SELECT * FROM $tablePokemons WHERE $columnPokemonId = ?',
        [id],
      );
      return dbEntity;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<CashingStatus> saveEntityById(
      int id, Map<String, dynamic> entity) async {
    try {
      await database.insert(
        tablePokemons,
        entity,
      );
      return CashingStatus.success;
    } catch (e) {
      return CashingStatus.failure;
    }
  }
}

class SQliteEntitiesDataSource extends ILocalDataSourceEntities {
  late final Database database;

  SQliteEntitiesDataSource(this.database);

  @override
  Future<CashingStatus> saveEntities(
      List<Map<String, dynamic>> entities) async {
    try {
      for (final entity in entities) {
        await database.insert(
          tablePokemonItems,
          entity,
        );
      }
      return CashingStatus.success;
    } catch (e) {
      return CashingStatus.failure;
    }
  }

  @override
  Future<List<Map>> getEntities() async {
    List<Map> dbMemorysList =
        await database.rawQuery('SELECT * FROM $tablePokemonItems');

    if (dbMemorysList.isNotEmpty) {
      return dbMemorysList;
    } else {
      throw Exception('Error reading from DB');
    }
  }
}
