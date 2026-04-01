import 'package:flutter/material.dart';
import 'package:gymoraly/views/edit_profile_view.dart';
import 'package:gymoraly/views/privacy_view.dart';
import 'package:gymoraly/views/setttings_view.dart';
import 'package:gymoraly/views/subscriptions_view.dart';
import '../controllers/profile_controller.dart'; // Importe o seu controller

class ProfileView extends StatelessWidget {
  final String userName;

  // Instancia o controller para gerenciar o logout
  final controller = ProfileController();

  ProfileView({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER AZUL ---
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 60, left: 25),
                  child: const Text(
                    'Perfil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // --- FOTO DE PERFIL ---
                Positioned(
                  top: 100,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 70),

            // --- NOME E INFO ---
            Text(
              userName,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Membro Premium',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Colors.grey.shade400, size: 16),
                const SizedBox(width: 5),
                const Text(
                  'São Paulo, Brasil',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // --- BOTÃO EDITAR PERFIL ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width:
                    double.infinity, // Faz o botão ocupar a largura disponível
                height: 55, // Altura padrão do seu design
                child: ElevatedButton(
                  onPressed: () {
                    // Navega para a tela de edição
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileView(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        primaryColor, // Sua cor principal definida no projeto
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Editar perfil',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // --- OPÇÕES DE MENU ---
            // Na ProfileView:
            _buildProfileOption(
              Icons.lock_outline,
              'Privacidade',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyView())),
            ),
            _buildProfileOption(
              Icons.credit_card_rounded,
              'Assinaturas',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionsView())),
            ),
            _buildProfileOption(
              Icons.settings_outlined,
              'Configurações',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsView())),
            ),

            // Botão Sair
            _buildProfileOption(
              Icons.logout,
              'Sair',
              textColor: Colors.redAccent,
              onTap: () {
                _showLogoutDialog(context);
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Função para mostrar o alerta de confirmação
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair'),
        content: const Text(
          'Deseja realmente encerrar sua sessão no Gymoraly?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o diálogo
              controller.logout(
                context,
              ); // Chama o método de logout no controller
            },
            child: const Text(
              'Sair',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para os cards de opções
  Widget _buildProfileOption(
    IconData icon,
    String title, {
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ListTile(
          onTap: onTap, // Atribui a função de clique aqui
          leading: Icon(icon, color: textColor ?? Colors.black87),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: textColor ?? Colors.black87,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
