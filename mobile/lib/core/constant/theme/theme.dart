import 'package:flutter/material.dart';
import 'package:mobile/core/constant/theme/dark_theme.dart';
import 'package:mobile/core/constant/theme/light_theme.dart';

class KAppTheme {
  static ThemeData get lightTheme => KLightTheme.light;
  static ThemeData get darkTheme => KDarkTheme.dark;
}
