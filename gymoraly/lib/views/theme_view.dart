import 'package:flutter/material.dart';

class ThemeView extends StatelessWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, "Tema", Icons.dark_mode_rounded),
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                _buildThemeCard("Claro", Icons.light_mode, true),
                const SizedBox(height: 15),
                _buildThemeCard("Escuro", Icons.dark_mode, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard(String title, IconData icon, bool isSelected) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: isSelected ? Border.all(color: Colors.blue, width: 2) : null),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: isSelected ? const Icon(Icons.radio_button_checked, color: Colors.blue) : const Icon(Icons.radio_button_off, color: Colors.grey),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title, IconData icon) {
    return Stack(alignment: Alignment.center, clipBehavior: Clip.none, children: [
      Container(height: 160, width: double.infinity, decoration: const BoxDecoration(color: Color(0xFF2196F3), borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))), child: SafeArea(child: Row(children: [IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)), Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))]))),
      Positioned(top: 110, child: Container(padding: const EdgeInsets.all(15), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)]), child: Icon(icon, size: 50, color: const Color(0xFF2196F3)))),
    ]);
  }
}