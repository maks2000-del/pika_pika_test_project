import 'package:flutter/material.dart';

import '../pages/main/home_page.dart';
import '../theme/theme_provider.dart';
import 'app_themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      theme: darkTheme,
      child: const MaterialApp(home: HomePage()),
    );
  }
}
