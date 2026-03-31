import 'package:flutter/material.dart';
import 'package:gymoraly/views/main_wrapper.dart';
// Verifique se os caminhos abaixo batem com as suas pastas
import '../models/login_model.dart';
import '../models/user_model.dart';

import '../services/database_helper.dart' hide User; 

class LoginController extends ChangeNotifier {
  // Você PRECISA dessa linha para que o método login reconheça o "model"
  final LoginModel model = LoginModel();

  bool isPasswordVisible = false;
  bool isLoading = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    // 1. Inicia o loading
    isLoading = true;
    notifyListeners();

    try {
      // 2. Busca no SQLite usando os dados do model
      final User? user = await DatabaseHelper().loginUser(
        model.email,
        model.password,
      );

      // 3. Para o loading
      isLoading = false;
      notifyListeners();

      // 4. Verifica se o contexto ainda é válido (boa prática em Flutter)
      if (!context.mounted) return;

      // No seu LoginController.dart
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MainWrapper(userName: user.name), // CHAME O WRAPPER AQUI
          ),
        );


      } else {
        // LOGIN FALHOU
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('E-mail ou senha incorretos.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      // TRATAMENTO DE ERRO DE BANCO
      isLoading = false;
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro no banco de dados: $e')));
      }
    }
  }
}