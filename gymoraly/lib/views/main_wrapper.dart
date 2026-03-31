import 'package:flutter/material.dart';
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
    // Aqui listamos as páginas na ordem dos ícones
    final List<Widget> _pages = [
      HomeView(userName: widget.userName), // Índice 0
      const ProgressView(),               // Índice 1
      const Center(child: Text("Comunidade")), 
      const Center(child: Text("Perfil")),
    ];

    return Scaffold(
      // O IndexedStack faz a mágica de trocar a tela
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Isso agora muda a tela de verdade!
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2196F3),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Treinos'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progresso'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Comunidade'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}