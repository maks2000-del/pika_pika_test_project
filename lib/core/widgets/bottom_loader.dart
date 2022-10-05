import 'package:flutter/material.dart';

import '../theme/app_themes.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkTheme.primaryBackgroundColor,
      child: const Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 1.5),
        ),
      ),
    );
  }
}
