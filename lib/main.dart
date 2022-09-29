import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'presentation/app/app.dart';
import 'presentation/di/injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initInjector();
  runApp(
    const GetMaterialApp(
      home: App(),
    ),
  );
}
