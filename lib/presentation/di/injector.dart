import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pika_pika_test_project/presentation/pages/main/bloc/home_bloc.dart';

import '../../domain/repositories/remote_data_repository.dart';
import '../pages/detailed_info/bloc/detailed_info_bloc.dart';

GetIt get i => GetIt.instance;

void initInjector() {
  i.registerSingleton<http.Client>(http.Client());
  // i.registerSingleton<IPreferenceDataSource>(PreferenceDataSource());

  i.registerSingleton<RemoteDataRepository>(RemoteDataRepository());

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
