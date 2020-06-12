import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size size() {
    return MediaQuery.of(this).size;
  }

  double pcw(double perCent) {
    return size().width * perCent / 100; 
  }

  double pch(double perCent) {
    return size().height * perCent / 100;
  }
}
