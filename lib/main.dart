import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'features/pokemon_app/presentation/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const GetMaterialApp(
      home: App(),
    ),
  );
}
