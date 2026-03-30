import 'package:flutter/material.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final controller = RegisterController();

  // Helper de Input (Mesmo padrão da LoginView)
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
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 56,
          child: TextField(
            onChanged: onChanged,
            obscureText: isPassword,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              suffixIcon: suffixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF2196F3), width: 1.5),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const Text(
                    'Criar Conta',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: primaryColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Junte-se à comunidade Gymoraly',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                  const SizedBox(height: 40),

                  _buildInputGroup(
                    label: 'Nome Completo',
                    hint: 'Seu nome',
                    onChanged: (value) => controller.model.name = value,
                  ),
                  const SizedBox(height: 20),

                  _buildInputGroup(
                    label: 'E-mail',
                    hint: 'exemplo@email.com',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => controller.model.email = value,
                  ),
                  const SizedBox(height: 20),

                  _buildInputGroup(
                    label: 'Senha',
                    hint: 'Mínimo 6 caracteres',
                    isPassword: !controller.isPasswordVisible,
                    onChanged: (value) => controller.model.password = value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey, size: 20,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildInputGroup(
                    label: 'Confirmar Senha',
                    hint: 'Repita sua senha',
                    isPassword: !controller.isPasswordVisible,
                    onChanged: (value) => controller.model.confirmPassword = value,
                  ),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: controller.isLoading ? null : () => controller.register(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: controller.isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Cadastrar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}