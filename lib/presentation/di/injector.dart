import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pika_pika_test_project/presentation/pages/main/bloc/home_bloc.dart';

import '../pages/detailed_info/bloc/detailed_info_bloc.dart';

GetIt get i => GetIt.instance;

void initInjector() {
  i.registerSingleton(http.Client());
  // i.registerSingleton<IPreferenceDataSource>(PreferenceDataSource());

  // i.registerSingleton<IAuthenticationRepository>(AuthenticationRepository(i.get()));
  // i.registerSingleton<IRepository>(AuthenticationRepository());

  i.registerFactory(
    () => DetailedInfoBloc(httpClient: i.get())
      ..add(
        PokemonFetched(),
      ),
  );
  i.registerFactory(
    () => HomeBloc(httpClient: i.get())
      ..add(
        PokemonsFetched(),
      ),
  );
}
