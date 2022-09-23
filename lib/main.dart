import 'package:flutter/material.dart';

import 'presentation/app/app.dart';
import 'presentation/di/injector.dart';

void main() {
  initInjector();
  runApp(const App());
}
