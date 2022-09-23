import 'package:flutter/material.dart';

import '../pages/main/home_page.dart';

class App extends MaterialApp {
  const App({Key? key})
      : super(
          key: key,
          home: const HomePage(),
        );
}
