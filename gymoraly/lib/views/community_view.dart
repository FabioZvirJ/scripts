import 'package:flutter/material.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);
    const darkIconColor = Color(0xFF2D3142); // Cor escura dos ícones da lista

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER AZUL ---
            Container(
              height: 160,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              padding: const EdgeInsets.only(top: 60, left: 25),
              child: const Text(
                'Comunidade',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // --- CONTEÚDO PRINCIPAL (CARD BRANCO) ---
            Transform.translate(
              offset: const Offset(0, -30),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Barra de Busca
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search, color: Colors.grey),
                            hintText: 'Encontre tópicos',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Seção Formim (Tópicos)
                      _buildSectionHeader('Fóruns Ativos', Icons.menu),
                      const SizedBox(height: 15),
                      _buildTopicItem(
                        'Ideias de Treino',
                        '1 novo tópico',
                        Icons.swap_vert_rounded,
                        darkIconColor,
                      ),
                      _buildTopicItem(
                        'Dicas de Nutrição',
                        '5 novos tópicos',
                        Icons.g_mobiledata_rounded,
                        darkIconColor,
                      ),
                      _buildTopicItem(
                        'Treino Coletivo',
                        '2 novos tópicos',
                        Icons.chat_bubble_outline_rounded,
                        darkIconColor,
                      ),

                      const Divider(height: 40),

                      // Seção Timer Rápido
                      _buildSectionHeader('Cronômetro Rápido', Icons.more_horiz),
                      const SizedBox(height: 15),
                      _buildUserRow('Glynto Silva'),
                      
                      const Divider(height: 40),

                      // Seção Recomendar
                      const Text(
                        'Minhas Recomendações',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Icon(Icons.add, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Icon(icon, color: Colors.black87, size: 20),
      ],
    );
  }

  Widget _buildTopicItem(String title, String subtitle, IconData icon, Color circleColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
        ],
      ),
    );
  }

  Widget _buildUserRow(String name) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: const Icon(Icons.person, color: Colors.blue),
        ),
        const SizedBox(width: 15),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        const Icon(Icons.more_horiz, color: Colors.grey),
      ],
    );
  }
}