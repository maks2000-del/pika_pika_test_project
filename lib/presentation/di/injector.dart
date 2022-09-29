import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pika_pika_test_project/presentation/pages/main/bloc/home_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/local_data_source/local_data_source.dart';
import '../../domain/repositories/cash_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';
import '../pages/detailed_info/bloc/detailed_info_bloc.dart';
import '../utils/sqlite_open_helper.dart';

GetIt get i => GetIt.instance;

void initInjector() {
  i.registerSingleton<http.Client>(http.Client());
  _setUpSQLite();
  _setUpRepository();
  _setUpBloc();
}

void _setUpBloc() {
  i.registerFactory(
    () => HomeBloc()
      ..add(
        PokemonsFetched(),
      ),
  );

  i.registerFactory<DetailedInfoBloc>(
    () => DetailedInfoBloc(),
  );
}

void _setUpSQLite() async {
  SqliteDataBaseOpenHelper sqliteDataBaseOpenHelper =
      SqliteDataBaseOpenHelper();
  Database database = await sqliteDataBaseOpenHelper.initDatabase();
  i.registerSingleton<SQliteEntityDataSource>(SQliteEntityDataSource(database));
  i.registerSingleton<SQliteEntitiesDataSource>(
      SQliteEntitiesDataSource(database));
}

void _setUpRepository() {
  i.registerSingleton<CashDataRepository>(CashDataRepository());
  i.registerSingleton<RemoteDataRepository>(RemoteDataRepository());
}
