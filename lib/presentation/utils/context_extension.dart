import 'package:flutter/material.dart';

import '../../core_ui/theme/app_theme.dart';
import '../../core_ui/theme/theme_provider.dart';

extension ContextExtensions on BuildContext {
  AppTheme get theme => ThemeProvider.of(this).theme;
}
