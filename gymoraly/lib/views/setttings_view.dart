import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, "Configurações", Icons.settings_rounded),
          const SizedBox(height: 80),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              children: [
                _buildOption(Icons.notifications_none, "Notificações"),
                _buildOption(Icons.language_rounded, "Idioma"),
                _buildOption(Icons.dark_mode_outlined, "Tema"),
                _buildOption(Icons.info_outline, "Sobre o App"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title, IconData icon) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF2196F3),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        Positioned(top: 110, child: Container(padding: const EdgeInsets.all(15), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(icon, size: 50, color: const Color(0xFF2196F3)))),
      ],
    );
  }

  Widget _buildOption(IconData icon, String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {},
      ),
    );
  }
}