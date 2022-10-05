import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../theme/app_themes.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkTheme.secondaryBackgroundColor,
      child: Center(
        child: Lottie.asset(
          'assets/lottie/loading.json',
          width: 350,
          height: 200,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
