import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../../data/local_data_source/local_data_source.dart';
import '../../domain/repositories/cash_data_repository.dart';
import '../../domain/repositories/interfaces/pokemon_data_interface.dart';
import '../../domain/repositories/remote_data_repository.dart';
import '../../domain/usecases/data_usecase.dart';
import '../pages/detailed_info/bloc/detailed_info_bloc.dart';
import '../pages/main/bloc/home_bloc.dart';
import '../utils/sqlite_open_helper.dart';

GetIt get i => GetIt.instance;

void initInjector() async {
  i.registerSingleton<http.Client>(
    http.Client(),
  );

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
    () => DetailedInfoBloc()
      ..add(
        DetailedInfoConnectionChecked(),
      ),
  );
}

void _setUpSQLite() async {
  Database database = await SqliteDataBaseOpenHelper.initDatabase();

  i.registerFactory<SQliteEntityDataSource>(
    () => SQliteEntityDataSource(database),
  );
  i.registerFactory<SQliteEntitiesDataSource>(
    () => SQliteEntitiesDataSource(database),
  );
}

void _setUpRepository() async {
  i.registerSingleton<CashDataRepository>(
    CashDataRepository(),
  );
  i.registerSingleton<RemoteDataRepository>(
    RemoteDataRepository(),
  );
  final connectivity = await Connectivity().checkConnectivity();
  final IDataRepository dataRepository =
      (connectivity != ConnectivityResult.none)
          ? i.get<RemoteDataRepository>()
          : i.get<CashDataRepository>();

  i.registerFactory<HomeUsecase>(
    () => HomeUsecase(dataRepository),
  );
}
