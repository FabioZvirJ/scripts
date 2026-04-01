import 'package:flutter/material.dart';
import '../controllers/theme_controller.dart'; 

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});

  @override
  State<ThemeView> createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  @override
  Widget build(BuildContext context) {
    // O AnimatedBuilder faz essa tela se redesenhar sempre que o tema mudar
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, child) {
        // Verifica se o modo atual é escuro
        final isDark = themeController.isDarkMode;

        return Scaffold(
          // Se for escuro, usa fundo escuro. Se for claro, usa o fundo claro.
          backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
          body: Column(
            children: [
              _buildHeader(context, "Tema", Icons.dark_mode_rounded),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    // Card do Tema Claro
                    _buildThemeCard(
                      title: "Claro", 
                      icon: Icons.light_mode, 
                      isSelected: !isDark, // Está selecionado se isDark for falso
                      isDarkTheme: isDark,
                      onTap: () => themeController.toggleTheme(false), // Ativa modo claro
                    ),
                    const SizedBox(height: 15),
                    // Card do Tema Escuro
                    _buildThemeCard(
                      title: "Escuro", 
                      icon: Icons.dark_mode, 
                      isSelected: isDark, // Está selecionado se isDark for verdadeiro
                      isDarkTheme: isDark,
                      onTap: () => themeController.toggleTheme(true), // Ativa modo escuro
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  // Atualizei o método para receber os parâmetros novos e adaptar as cores
  Widget _buildThemeCard({
    required String title, 
    required IconData icon, 
    required bool isSelected, 
    required bool isDarkTheme,
    required VoidCallback onTap,
  }) {
    // Cores dinâmicas para os cards dependendo do tema do app
    final cardColor = isDarkTheme ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkTheme ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: cardColor, 
        borderRadius: BorderRadius.circular(20), 
        // Se estiver selecionado, coloca a borda azul. Se não, deixa transparente
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.transparent, 
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            // Sombra mais suave no modo escuro
            color: isDarkTheme ? Colors.black.withOpacity(0.2) : Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap, // Executa a mudança de tema
        leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
        trailing: isSelected 
          ? const Icon(Icons.radio_button_checked, color: Colors.blue) 
          : const Icon(Icons.radio_button_off, color: Colors.grey),
      ),
    );
  }

  // O Header continua o mesmo, mantendo o azul principal
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