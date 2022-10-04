import 'package:flutter/material.dart';

import '../../presentation/app/app_themes.dart';

class NoDataScreen extends StatelessWidget {
  final String textToPrint;

  const NoDataScreen({Key? key, required this.textToPrint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        textToPrint,
        style: TextStyle(
          color: darkTheme.textColor,
        ),
      ),
    );
  }
}
