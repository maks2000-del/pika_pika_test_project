import 'package:sqflite/sqflite.dart';
import 'cash_data_repository.dart';
import 'helpers/sqlite_open_helper.dart';
import 'interfaces/i_local_data_source.dart';

class LocalDataProvider implements ILocalDataSourceEntity {
  late final Database database;

  LocalDataProvider(this.database);

  @override
  Future<List<Map>> getEntityById(int id) async {
    try {
      List<Map<String, dynamic>> dbEntity = await database.rawQuery(
        'SELECT * FROM $tablePokemons WHERE $columnPokemonId = ?',
        [id],
      );
      return dbEntity;
    } catch (e) {
      throw Exception('Error reading from DB');
    }
  }

  @override
  Future<CashingStatus> saveEntityById(
    int id,
    Map<String, dynamic> entity,
  ) async {
    try {
      await database.insert(tablePokemons, entity);
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

  @override
  Future<CashingStatus> saveEntities(
    List<Map<String, dynamic>> entities,
  ) async {
    try {
      for (final entity in entities) {
        await database.insert(tablePokemonItems, entity);
      }
      return CashingStatus.success;
    } catch (e) {
      return CashingStatus.failure;
    }
  }
}
