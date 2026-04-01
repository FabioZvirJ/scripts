import 'package:flutter/material.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, "Sobre o App", Icons.info_rounded),
          const SizedBox(height: 80),
          const Text("Gymoraly", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2196F3))),
          const Text("Versão 1.0.0", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: const Text(
                "O Gymoraly foi desenvolvido para ajudar você a alcançar seus objetivos fitness com praticidade e organização. Continue treinando firme!",
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5),
              ),
            ),
          ),
        ],
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