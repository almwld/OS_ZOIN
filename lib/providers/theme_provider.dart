import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _currentTheme = 'Turquoise';
  
  bool get isDarkMode => _isDarkMode;
  String get currentTheme => _currentTheme;
  
  Color get primaryColor {
    switch (_currentTheme) {
      case 'Cyan':
        return const Color(0xFF00E5FF);
      case 'Green':
        return const Color(0xFF4CAF50);
      case 'Blue':
        return const Color(0xFF2196F3);
      case 'Purple':
        return const Color(0xFF9C27B0);
      case 'Orange':
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF00BCD4); // Turquoise
    }
  }

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setTheme(String theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        surface: Colors.white,
        background: Colors.grey[50]!,
      ),
      fontFamily: 'Cairo',
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: primaryColor,
        surface: Colors.grey[900]!,
        background: Colors.black,
      ),
      fontFamily: 'Cairo',
    );
  }
}
