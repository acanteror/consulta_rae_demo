import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final double fontSize;

  const TitleWidget({this.fontSize = 30});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'CONSULTA',
        style: TextStyle(
          fontSize: fontSize,
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