import 'package:flutter/material.dart';

import '../../core_ui/theme/theme_provider.dart';
import '../pages/main/home_page.dart';
import 'app_themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      theme: darkTheme,
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
