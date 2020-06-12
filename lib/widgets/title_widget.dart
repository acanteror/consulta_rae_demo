import 'package:flutter/material.dart';
import 'package:rae_test/extension/context_extension.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'CONSULTA',
        style: TextStyle(
          fontSize: context.pcw(8),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: 'R',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          TextSpan(
            text: 'AE',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
