import 'package:flutter/material.dart';
import '../models/login_model.dart';

class LoginController extends ChangeNotifier {
  final model = LoginModel();
  bool isPasswordVisible = false;
  bool isLoading = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (model.isValid) {
      isLoading = true;
      notifyListeners();

      // Simulação de login
      await Future.delayed(const Duration(seconds: 2));
      
      isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail ou senha inválidos.')),
      );
    }
  }
}