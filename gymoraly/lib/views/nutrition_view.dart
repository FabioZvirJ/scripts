import 'package:flutter/material.dart';

class NutritionView extends StatelessWidget {
  const NutritionView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: primaryColor, // Fundo azul para a parte superior (Header)
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER TITLE ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Text(
                'Nutrição',
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
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- SAUDAÇÃO ---
                      const Text(
                        'Olá, Fabio 👋',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Dicas e alimentação',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(height: 25),

                      // --- CARD 1: MINHAS REFEIÇÕES ---
                      _buildMealsCard(primaryColor),
                      const SizedBox(height: 25),

                      // --- CARD 2: PLANO ALIMENTAR ---
                      _buildDietPlanCard(primaryColor),
                      const SizedBox(height: 25),

                      // --- SEÇÃO: RECEITAS SAUDÁVEIS ---
                      const Text(
                        'Receitas saudáveis',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 15),
                      
                      _buildRecipeItem(
                        title: 'Omelete de claras',
                        subtitle: 'Ideia de café da manhã proteico',
                        imageUrl: 'https://images.unsplash.com/photo-1510693206972-df098062cb71?auto=format&fit=crop&q=80&w=200', // Imagem de exemplo
                      ),
                      
                      const SizedBox(height: 30), // Espaço para não grudar no fim da tela
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
  // WIDGETS AUXILIARES (COMPONENTES DA TELA)
  // ==========================================

  // --- CARD DE REFEIÇÕES ---
  Widget _buildMealsCard(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título do Card
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.green, size: 18),
              ),
              const SizedBox(width: 10),
              const Text('Minhas refeições hoje', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 38, bottom: 15),
            child: Text('Acompanhe suas refeições do dia', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          
          // Lista de refeições
          _buildMealRow('Café da manhã', true),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          _buildMealRow('Almoço', false),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          _buildMealRow('Jantar', false),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          _buildMealRow('Lanches', false),
          
          const SizedBox(height: 20),
          
          // Botão Adicionar
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 20),
              label: const Text('Adicionar refeição', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }

  // Linha individual de cada refeição (Café, Almoço, etc)
  Widget _buildMealRow(String title, bool isDone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.cancel, 
            color: isDone ? Colors.green : Colors.redAccent,
            size: 22,
          ),
          const SizedBox(width: 15),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87))),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  // --- CARD DO PLANO ALIMENTAR ---
  Widget _buildDietPlanCard(Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          // Imagem na esquerda
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            child: Image.network(
              'https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&q=80&w=200', // Imagem de salada
              height: 140,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          // Textos e Botão na direita
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Plano alimentar saudável', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 5),
                  const Text('Sugestão de cardápio balanceado para ganhar massa magra', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.zero,
                        elevation: 0,
                      ),
                      child: const Text('Ver plano completo', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- CARD DE RECEITA INDIVIDUAL ---
  Widget _buildRecipeItem({required String title, required String subtitle, required String imageUrl}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          // Imagem da receita
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            child: Image.network(
              imageUrl,
              height: 75,
              width: 85,
              fit: BoxFit.cover,
            ),
          ),
          // Textos
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ),
          ),
          // Ícone de seta
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}