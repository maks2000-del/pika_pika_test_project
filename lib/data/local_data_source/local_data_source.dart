import 'package:sqflite/sqflite.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/cash_data_repository.dart';
import '../../presentation/utils/sqlite_open_helper.dart';
import '../models/pokemon_item.dart';
import 'interfaces/i_local_data_source.dart';

class SQliteEntityDataSource implements ILocalDataSourceEntity {
  late final Database database;

  SQliteEntityDataSource(this.database);

  @override
  Future<dynamic> getEntityById(String id) async {
    try {
      final dbMemorysList = await database.rawQuery(
        'SELECT * FROM $tableMemorys WHERE $columnCoupleId = ?',
        [id],
      );
      return dbMemorysList;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<CashingStatus> saveEntityById(
      String id, Map<String, dynamic> entity) async {
    //TODO check id for no repeat

    try {
      await database.insert(
        tableMemorys,
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
          tableMemorys,
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
        await database.rawQuery('SELECT * FROM $tableMemorys');

    if (dbMemorysList.isNotEmpty) {
      return dbMemorysList;
    } else {
      throw Exception('Error reading from DB');
    }
  }
}
