import 'package:flutter/material.dart';
import 'package:gymoraly/views/add_workout_view.dart';

class WorkoutSplitsView extends StatelessWidget {
  const WorkoutSplitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Escolher Divisão',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20), // O card começa no pixel 20 da tela
        children: [
          _buildSplitCard(context, 'Full Body'),
          _buildSplitCard(context, 'AB'),
          _buildSplitCard(context, 'ABC'),
          _buildSplitCard(context, 'ABCD'),
          _buildSplitCard(context, 'ABCDE'),
          _buildSplitCard(context, 'Push / Pull / Legs (PPL)'),
          _buildSplitCard(context, 'Upper / Lower'),
          _buildSplitCard(context, 'Push / Pull'),
          _buildSplitCard(context, 'Full Body + Upper/Lower'),
          _buildSplitCard(context, 'PPL + Upper/Lower'),
          _buildSplitCard(context, 'Arnold Split'),
          _buildSplitCard(context, 'Bro Split'),
          _buildSplitCard(context, 'Torso / Legs'),
          _buildSplitCard(context, 'Push / Pull / Legs / Upper / Lower'),
        ],
      ),
    );
  }

  // Estilo do título da categoria
  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2196F3),
        ),
      ),
    );
  }

  // Dicionário de explicações
String _obterExplicacaoTreino(String title) {
    switch (title) {
      case 'Full Body': 
        return 'Sessão de treinamento global que recruta todos os grandes grupos musculares. Ideal para maximizar o gasto calórico e estímulos neuromusculares.';
      case 'AB': 
        return 'Bifurcação do treinamento, comumente separada em membros superiores e inferiores, permitindo maior volume direcionado e recuperação sistêmica.';
      case 'ABC': 
        return 'Divisão sinérgica tradicional. Agrupa músculos agonistas e auxiliares (ex: Peito e Tríceps) para otimizar o tempo de tensão e o descanso isolado.';
      case 'ABCD': 
        return 'Segmentação avançada que isola grupos musculares específicos, proporcionando alto volume de treinamento por sessão e hipertrofia focada.';
      case 'ABCDE': 
        return 'Isolamento muscular extremo. Voltado para atletas que necessitam de sobrecarga máxima e exaustão completa em um único grupamento.';
      case 'Push / Pull / Legs (PPL)': 
        return 'Agrupamento baseado em biomecânica de movimento (Puxar, Empurrar e Pernas). Altamente eficiente para progressão de carga e prevenção de fadiga.';
      case 'Upper / Lower': 
        return 'Separação anatômica estrita entre tronco/membros superiores e membros inferiores. Promove excelente equilíbrio de desenvolvimento estrutural.';
      case 'Push / Pull': 
        return 'Estruturação focada puramente na cinesiologia dos movimentos, alternando o recrutamento de cadeias musculares anteriores e posteriores.';
      case 'Full Body + Upper/Lower': 
        return 'Abordagem híbrida que combina os benefícios metabólicos de ativação global com a especificidade do treinamento segmentado.';
      case 'PPL + Upper/Lower': 
        return 'Periodização complexa que une estímulos focados em máxima hipertrofia (PPL) com sessões orientadas ao ganho de força bruta (Upper/Lower).';
      case 'Arnold Split': 
        return 'Trabalho de musculatura antagonista (Peito e Costas) e isolada (Ombros e Braços). Exige alto condicionamento e promove vascularização.';
      case 'Bro Split': 
        return 'Foco unifocal de alto volume. Dedica uma sessão inteira à quebra de fibras e exaustão total de um único grupamento muscular.';
      case 'Torso / Legs': 
        return 'Agrupa os grandes músculos do tronco em uma sessão e foca nas extremidades inferiores na seguinte, otimizando o fluxo sanguíneo central.';
      case 'Push / Pull / Legs / Upper / Lower': 
        return 'Sistema híbrido de altíssimo rendimento que mescla divisões biomecânicas com segmentação anatômica para periodização avançada.';
      default: 
        return 'Selecione esta estrutura base para configurar e personalizar seus blocos de exercícios.';
    }
  }

  // ==========================================
  // CARD DO TREINO COM O BALÃO ALINHADO À ESQUERDA E CORTADO À DIREITA
  // ==========================================
  Widget _buildSplitCard(BuildContext context, String title) {
    const primaryColor = Color(0xFF2196F3);

    return Tooltip(
      message: _obterExplicacaoTreino(title),
      waitDuration: const Duration(seconds: 2),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(2), // Quadrado
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), 
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
        border: Border.all(color: primaryColor.withOpacity(0.3), width: 1.5), 
      ),
      textStyle: TextStyle(
        color: Colors.grey.shade800, 
        fontSize: 14, 
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
      
      // 👇 HEIGHT GORDO: Deixei 15 em cima e embaixo para ficar recheado
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      
      // 👇 O SEGREDO DO ALINHAMENTO:
      // left: 20 -> Faz a borda azul alinhar perfeitamente com a borda do card
      // right: 80 -> Corta a caixa antes dela chegar no final direito
      margin: const EdgeInsets.only(left: 20, right: 80), 
      
      preferBelow: true,
      verticalOffset: 25, // Joga o balão pra baixo do card
      
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2), 
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: ListTile(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: () async {
            final exercicioEscolhido = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddWorkoutView()),
            );

            if (exercicioEscolhido != null && context.mounted) {
              Navigator.pop(context, exercicioEscolhido);
            }
          },
        ),
      ),
    );
  }
}