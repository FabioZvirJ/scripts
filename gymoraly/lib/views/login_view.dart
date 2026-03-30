import 'package:flutter/material.dart';
import 'package:gymoraly/views/register_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = LoginController();

  // --- COMPONENTE PADRONIZADO DE INPUT ---
  Widget _buildInputGroup({
    required String label,
    required String hint,
    required Function(String) onChanged,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label fixo acima do input
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        // Campo de texto padronizado
        SizedBox(
          height: 56, // Altura padrão de inputs modernos
          child: TextField(
            onChanged: onChanged,
            obscureText: isPassword,
            keyboardType: keyboardType,
            cursorColor: const Color(0xFF2196F3),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              suffixIcon: suffixIcon,
              // Bordas consistentes
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF2196F3),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    // LOGO E TÍTULO
                    const Icon(
                      Icons.fitness_center,
                      size: 50,
                      color: primaryColor,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Gymoraly',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: primaryColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // INPUT E-MAIL
                    _buildInputGroup(
                      label: 'E-mail',
                      hint: 'exemplo@email.com',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => controller.model.email = value,
                    ),
                    const SizedBox(height: 20),

                    // INPUT SENHA
                    _buildInputGroup(
                      label: 'Senha',
                      hint: '••••••••',
                      isPassword: !controller.isPasswordVisible,
                      onChanged: (value) => controller.model.password = value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),

                    // ESQUECI SENHA
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // BOTÃO ENTRAR PADRONIZADO
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: controller.isLoading
                            ? null
                            : () => controller.login(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: controller.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // RODAPÉ
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ainda não tem conta? ',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        // No login_view.dart
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterView(),
                              ),
                            );
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
