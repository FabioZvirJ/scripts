import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3); // Azul do logo

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Gymoraly
                    const Text(
                      'Gymoraly',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Bem-vindo(a) de volta!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Input E-mail
                    TextField(
                      onChanged: (value) => controller.model.email = value,
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Input Senha
                    TextField(
                      onChanged: (value) => controller.model.password = value,
                      obscureText: !controller.isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Botão Entrar
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: controller.isLoading
                            ? null
                            : () => controller.login(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: controller.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Esqueci minha senha',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Rodapé: Criar conta
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Ainda não tem conta? '),
                        GestureDetector(
                          onTap: () {
                            // O correto para GestureDetector é onTap
                            print("Ir para tela de cadastro");
                          },
                          child: const Text(
                            'Crie uma conta',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
