import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'domain/di/injector.dart';
import 'presentation/app/app.dart';
import 'data/local_data_source/helpers/sqlite_open_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteDataBaseOpenHelper.initialize();

  initInjector();
  runApp(
    const GetMaterialApp(
      home: App(),
    ),
  );
}
