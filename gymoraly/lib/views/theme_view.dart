import 'package:flutter/material.dart';

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});

  @override
  State<ThemeView> createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  // Estado que guarda qual tema está selecionado no momento
  String selectedTheme = 'Claro';

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
                // Não precisamos mais passar "true" ou "false", o método descobre sozinho
                _buildThemeCard("Claro", Icons.light_mode),
                const SizedBox(height: 15),
                _buildThemeCard("Escuro", Icons.dark_mode),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Atualizei o método para receber apenas o título e o ícone
  Widget _buildThemeCard(String title, IconData icon) {
    // Verifica se este card é o que está selecionado na variável de estado
    bool isSelected = selectedTheme == title;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(20), 
        // Se estiver selecionado, coloca a borda azul. Se não, deixa transparente para manter o tamanho
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.transparent, 
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          // Quando clicar, atualiza o estado para o título deste card
          setState(() {
            selectedTheme = title;
          });
        },
        leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: isSelected 
          ? const Icon(Icons.radio_button_checked, color: Colors.blue) 
          : const Icon(Icons.radio_button_off, color: Colors.grey),
      ),
    );
  }

  // Header mantido idêntico ao seu
  Widget _buildHeader(BuildContext context, String title, IconData icon) {
    return Stack(alignment: Alignment.center, clipBehavior: Clip.none, children: [
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
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white), 
                onPressed: () => Navigator.pop(context)
              ), 
              Text(
                title, 
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)
              )
            ]
          )
        )
      ),
      Positioned(
        top: 110, 
        child: Container(
          padding: const EdgeInsets.all(15), 
          decoration: const BoxDecoration(
            color: Colors.white, 
            shape: BoxShape.circle, 
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)]
          ), 
          child: Icon(icon, size: 50, color: const Color(0xFF2196F3))
        )
      ),
    ]);
  }
}