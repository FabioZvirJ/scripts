import 'package:flutter/material.dart';
// Certifique-se que o caminho abaixo está correto para o seu projeto
import '../models/register_model.dart'; 
import '../models/user_model.dart';
import '../services/database_helper.dart';

class RegisterController extends ChangeNotifier {
  // Inicializa o model que armazena os dados da tela
  final RegisterModel model = RegisterModel();
  
  bool isPasswordVisible = false;
  bool isLoading = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    // 1. Validação básica (definida no RegisterModel)
    if (model.isValid) {
      isLoading = true;
      notifyListeners();

      try {
        // 2. Criar o objeto de usuário para o banco de dados
        final newUser = User(
          name: model.name,
          email: model.email,
          password: model.password,
        );

        // 3. Chamar o serviço de banco de dados
        await DatabaseHelper().registerUser(newUser);

        // Sucesso!
        isLoading = false;
        notifyListeners();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Conta criada com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context); // Volta para a tela de login
        }
      } catch (e) {
        // Trata erros de banco de dados (ex: e-mail duplicado)
        isLoading = false;
        notifyListeners();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao salvar: $e')),
          );
        }
      }
    } else {
      // Caso o model.isValid retorne false
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha os campos corretamente.')),
      );
    }
  }
}