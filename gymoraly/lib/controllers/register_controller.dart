import 'package:flutter/material.dart';
import '../models/register_model.dart';

class RegisterController extends ChangeNotifier {
  final model = RegisterModel();
  bool isPasswordVisible = false;
  bool isLoading = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    if (model.isValid) {
      isLoading = true;
      notifyListeners();

      // Simulação de chamada de API
      await Future.delayed(const Duration(seconds: 2));

      isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta criada com sucesso!')),
      );
      Navigator.pop(context); // Volta para o login
    } else {
      String error = "Verifique os dados informados.";
      if (model.password != model.confirmPassword) {
        error = "As senhas não coincidem.";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }
}