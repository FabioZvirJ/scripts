import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  // Começamos com o tema Claro por padrão
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    // Isso avisa o MaterialApp para se redesenhar com as novas cores
    notifyListeners(); 
  }
}

// Instância global simples para acessar de qualquer lugar
final themeController = ThemeController();