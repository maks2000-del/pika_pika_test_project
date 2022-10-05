import '../cash_data_repository.dart';

abstract class ILocalDataSourceEntity {
  Future<dynamic> getEntityById(int id);
  Future<CashingStatus> saveEntityById(int id, Map<String, dynamic> entity);
  Future<List<Map>> getEntities();
  Future<CashingStatus> saveEntities(List<Map<String, dynamic>> entities);
}
