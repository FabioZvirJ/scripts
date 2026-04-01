import 'package:flutter/material.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, "Idioma", Icons.language_rounded),
          const SizedBox(height: 80),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              children: [
                _buildLangOption("Português (Brasil)", true),
                _buildLangOption("English (US)", false),
                _buildLangOption("Español", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLangOption(String lang, bool isSelected) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: ListTile(
        title: Text(lang, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        trailing: isSelected ? const Icon(Icons.check_circle, color: Color(0xFF2196F3)) : null,
        onTap: () {},
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