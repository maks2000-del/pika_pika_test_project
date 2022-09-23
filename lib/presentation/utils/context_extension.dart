import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/theme_provider..dart';

extension ContextExtensions on BuildContext {
  AppTheme get theme => ThemeProvider.of(this).theme;
}
