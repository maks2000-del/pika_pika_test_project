import 'package:pika_pika_test_project/domain/repositories/cash_data_repository.dart';

abstract class ILocalDataSourceEntity {
  Future<dynamic> getEntityById(String id);
  Future<CashingStatus> saveEntityById(String id, Map<String, String> entity);
}

abstract class ILocalDataSourceEntities {
  Future<List<Map>> getEntities();
  Future<CashingStatus> saveEntities(List<Map<String, String>> entities);
}
