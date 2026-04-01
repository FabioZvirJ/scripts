import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:gymoraly/views/profile_view.dart'; 

class HomeView extends StatelessWidget {
  final String userName;
  const HomeView({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER AZUL + CARD FLUTUANTE ---
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Fundo Azul Arredondado
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                  ),
                  padding: const EdgeInsets.only(top: 70, left: 25, right: 25), 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Joga um pra cada ponta
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. ÍCONE DE PERFIL NA ESQUERDA
                      // MouseRegion faz o cursor virar a "mãozinha" de clique
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileView(userName: userName),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2), // Bordinha branca
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const CircleAvatar(
                              radius: 20, 
                              backgroundColor: Color(0xFFE3F2FD), 
                              child: Icon(Icons.person, color: primaryColor, size: 24),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 15), // Espaço de segurança

                      // 2. TEXTO DE SAUDAÇÃO NA DIREITA
                      Flexible(
                        child: Text(
                          'Olá, $userName 👋',
                          textAlign: TextAlign.right, // Alinha o texto na direita
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                          maxLines: 1, 
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Card Branco de Objetivo (Posicionado entre o azul e o cinza)
                Positioned(
                  top: 140,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Objetivo',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          '45 min de treino',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        
                        // Bloco de Miniatura do Exercício
                        Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(Icons.fitness_center, color: primaryColor, size: 30),
                            ),
                            const SizedBox(width: 15),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Último treinado',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                Text(
                                  'Peito e Bíceps',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        // Botão Continuar
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () => print("Continuar Treino"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Continuar treino',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Espaço necessário para compensar o Positioned (Card)
            const SizedBox(height: 190),

            // --- SEÇÃO MEUS TREINOS ---
           // --- SEÇÃO MEUS TREINOS ---
            _buildSectionHeader('Meus treinos'),
            const SizedBox(height: 10),
            
            SizedBox(
              height: 110,
              // O ScrollConfiguration ensina o Flutter a aceitar o mouse como se fosse um dedo na tela!
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch, // Dedo no celular
                    PointerDeviceKind.mouse, // Clique e arraste no Windows/Web
                  },
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 25, right: 10),
                  children: [
                    _buildWorkoutCard('Treino A', 'Superior', primaryColor),
                    _buildWorkoutCard('Treino B', 'Inferior', primaryColor),
                    _buildWorkoutCard('Treino C', 'Cardio', primaryColor),
                    _buildAddWorkoutCard(primaryColor),
                  ],
                ),
              ),
            
              
            ),

            const SizedBox(height: 30),

            // --- SEÇÃO COMUNIDADE ---
            _buildSectionHeader('Destaques da Comunidade'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Center(
                  child: Text(
                    "Conteúdo da comunidade em breve...",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Ver tudo',
              style: TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Card padrão de treino
  Widget _buildWorkoutCard(String title, String subtitle, Color color) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bolt_rounded, color: color, size: 28),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Novo card de adicionar treino (com o sinal de +)
  Widget _buildAddWorkoutCard(Color color) {
    return GestureDetector(
      onTap: () {
        // Ação para criar um novo treino
        print("Clicou em adicionar treino!");
      },
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05), // Fundo azul bem clarinho
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5), 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: color, size: 26),
            ),
            const SizedBox(height: 8),
            Text(
              'Novo treino',
              style: TextStyle(
                color: color, 
                fontWeight: FontWeight.bold, 
                fontSize: 14
              ),
            ),
          ],
        ),
      ),
    );
  }
}