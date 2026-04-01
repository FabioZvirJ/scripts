import 'package:flutter/material.dart';

class ProfissionaisView extends StatefulWidget {
  const ProfissionaisView({super.key});

  @override
  State<ProfissionaisView> createState() => _ProfissionaisViewState();
}

class _ProfissionaisViewState extends State<ProfissionaisView> {
  // Controle de qual filtro está selecionado
  String selectedFilter = 'Nutricionista';

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: primaryColor, // Fundo azul atrás do cabeçalho
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER TITLE ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Text(
                'Profissionais',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // --- CONTEÚDO BRANCO ARREDONDADO ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- BARRA DE PESQUISA ---
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F6F8), // Cinza bem clarinho
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Buscar profissionais',
                            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                            prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // --- TÍTULO DA SEÇÃO ---
                      const Text(
                        'Encontre profissionais',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Conecte-se com especialistas',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 20),

                      // --- FILTROS (CHIPS) ---
                      Row(
                        children: [
                          _buildFilterChip('Nutricionista'),
                          const SizedBox(width: 10),
                          _buildFilterChip('Personal Trainer'),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // --- LISTA DE PROFISSIONAIS ---
                      _buildProfessionalCard(
                        name: 'Glynto Silva',
                        role: 'Personal Trainer',
                        followers: '6,532',
                        bio: 'Especialista em hipertrofia.\nVamos alcançar seus objetivos?',
                        imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?auto=format&fit=crop&q=80&w=200', // Placeholder homem fitness
                        isVerifiedDark: true,
                        primaryColor: primaryColor,
                      ),
                      
                      _buildProfessionalCard(
                        name: 'Renata Costa',
                        role: 'Nutricionista.',
                        followers: '4,210',
                        bio: 'Plano alimentar personalizado\npara ganho de massa.',
                        imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&q=80&w=200', // Placeholder mulher sorriso
                        isVerifiedDark: false,
                        primaryColor: primaryColor,
                      ),
                      
                      const SizedBox(height: 30), // Espaço no final da tela
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

  // ==========================================
  // WIDGETS AUXILIARES
  // ==========================================

  // --- WIDGET DO FILTRO (CHIP) ---
  Widget _buildFilterChip(String title) {
    bool isSelected = selectedFilter == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEef1F6) : Colors.transparent, // Fundo cinza azulado se selecionado
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.black87 : Colors.grey.shade500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // --- WIDGET DO CARD DO PROFISSIONAL ---
  Widget _buildProfessionalCard({
    required String name,
    required String role,
    required String followers,
    required String bio,
    required String imageUrl,
    required bool isVerifiedDark,
    required Color primaryColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagem de Perfil
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(width: 15),
            
            // Informações (Nome, Cargo, Seguidores)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                  Text(role, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle, 
                        size: 14, 
                        color: isVerifiedDark ? const Color(0xFF2C3E50) : Colors.green, // Baseado no seu print, o Glynto tem check escuro e a Renata verde
                      ),
                      const SizedBox(width: 4),
                      Text('$followers seguidores', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            
            // Botão Perfil
            SizedBox(
              height: 35,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text('Perfil', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 15),
        
        // Bio do profissional
        Text(
          bio,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4),
        ),
        
        // Linha divisória
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Divider(color: Colors.grey.shade200, height: 1),
        ),
      ],
    );
  }
}