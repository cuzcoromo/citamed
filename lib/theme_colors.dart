import 'package:flutter/material.dart';

extension ColorsUi on ColorScheme {
  Color get primaryColor =>
      brightness == Brightness.light
          ? Colors.blue.shade500
          : Colors.lightBlue; // Versión para modo oscuro
  Color get secondaryColor =>
      brightness == Brightness.light
          ? Colors.green
          : Colors.white; // Versión para modo oscuro
  // Color get background1 => brightness == Brightness.light ? Color(0xFF3f744a) : Colors.white;  // Versión para modo oscuro
  Color get background1 =>
      brightness == Brightness.light
          ? Color(0xFF589966)
          : Colors.white; // Versión para modo oscuro
  Color get background2 =>
      brightness == Brightness.light
          ? Color(0xFFdae5dd)
          : Colors.white; // Versión para modo oscuro
  Color get text1 =>
      brightness == Brightness.light
          // ? Color(0xFF3f744a)
          ? Colors.black54
          : Colors.white; // Versión para modo oscuro
  Color get text2 => Colors.grey.shade600;
  Color get errorColor => Colors.red;
  Color get iconColor => Colors.blueAccent;
}
