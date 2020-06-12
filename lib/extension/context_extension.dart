import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size size() {
    return MediaQuery.of(this).size;
  }

  ///percent of width
  double pcw(double perCent) {
    return size().width * perCent / 100; 
  }

  ///percent of height
  double pch(double perCent) {
    return size().height * perCent / 100;
  }

}
