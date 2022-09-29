import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'presentation/app/app.dart';
import 'presentation/di/injector.dart';
import 'presentation/utils/sqlite_open_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SqliteDataBaseOpenHelper.initialize();
  } catch (e) {
    print(e);
  }

  initInjector();
  runApp(
    const GetMaterialApp(
      home: App(),
    ),
  );
}
