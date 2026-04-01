import 'package:flutter/material.dart';
import 'package:gymoraly/views/community_view.dart';
import 'package:gymoraly/views/nutrition_view.dart';
import 'package:gymoraly/views/profile_view.dart';
// IMPORTANTE: Adicione o import da nova view de profissionais
import 'package:gymoraly/views/profissionais_view.dart'; 
import 'home_view.dart';
import 'progress_view.dart';

class MainWrapper extends StatefulWidget {
  final String userName;
  const MainWrapper({super.key, required this.userName});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 1. Adicionamos a ProfissionaisView no final da lista
    final List<Widget> _pages = [
      HomeView(userName: widget.userName), // Índice 0
      const ProgressView(),               // Índice 1
      const CommunityView(),              // Índice 2
      const NutritionView(),              // Índice 4
      const ProfissionaisView(),          // Índice 5 <-- NOVA TELA
    ];

    return Scaffold(
      // O IndexedStack faz a mágica de trocar a tela sem perder o estado delas
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Muda a tela de verdade!
          });
        },
        type: BottomNavigationBarType.fixed, // Mantém todos visíveis
        selectedItemColor: const Color(0xFF2196F3),
        unselectedItemColor: Colors.grey, // Garante que os inativos fiquem cinzas
        selectedFontSize: 12, // Um pouco menor para caber melhor os 6 itens
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Treinos'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progresso'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Comunidade'), 
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Nutrição'),
          BottomNavigationBarItem(icon: Icon(Icons.badge), label: 'Pro'),
        ],
      ),
    );
  }
}