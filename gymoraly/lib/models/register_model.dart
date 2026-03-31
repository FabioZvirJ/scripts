import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/database_helper.dart';

// 1. O MODELO COM TODOS OS CAMPOS
class RegisterModel {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  int age = 0;
  String gender = '';
  double height = 0.0;
  double weight = 0.0;

  // Validação do Passo 1
  bool get isStep1Valid => 
    name.isNotEmpty && 
    email.contains('@') && 
    password.length >= 6 && 
    password == confirmPassword;

  // ESTA LINHA ABAIXO RESOLVE O SEU ERRO:
  // Ela cria o "isValid" que o Controller está procurando
  bool get isValid => isStep1Valid;
}

// 2. O CONTROLLER
class RegisterController extends ChangeNotifier {
  final RegisterModel model = RegisterModel();
  
  bool isPasswordVisible = false;
  bool isLoading = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  // MÉTODO DE REGISTRO
  Future<void> register(BuildContext context) async {
    // Agora o "model.isValid" vai funcionar porque criamos ele ali em cima!
    if (model.isValid) {
      isLoading = true;
      notifyListeners();

      try {
        // Cria o User juntando tudo que foi salvo no model
        final newUser = User(
          name: model.name,
          email: model.email,
          password: model.password,
          age: model.age,
          gender: model.gender,
          height: model.height,
          weight: model.weight,
        );

        // Salva no banco de dados
        await DatabaseHelper().registerUser(newUser);

        isLoading = false;
        notifyListeners();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Conta criada com sucesso! Faça seu login.'),
              backgroundColor: Colors.green,
            ),
          );
          
         Navigator.of(context).popUntil((route) => route.isFirst);
        }
      } catch (e) {
        isLoading = false;
        notifyListeners();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao salvar: $e')),
          );
        }
      }
    } else {
      // Se a validação falhar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, verifique se os dados estão corretos.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}