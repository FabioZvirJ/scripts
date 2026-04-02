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
        padding: const EdgeInsets.all(20),
        children: [
          _buildCategoryHeader('🔹 Divisões básicas'),
          _buildSplitCard(context, 'Full Body'),
          _buildSplitCard(context, 'AB'),
          _buildSplitCard(context, 'ABC'),
          _buildSplitCard(context, 'ABCD'),
          _buildSplitCard(context, 'ABCDE'),

          const SizedBox(height: 25),
          _buildCategoryHeader('🔹 Divisões modernas / populares'),
          _buildSplitCard(context, 'Push / Pull / Legs (PPL)'),
          _buildSplitCard(context, 'Upper / Lower'),
          _buildSplitCard(context, 'Push / Pull'),
          _buildSplitCard(context, 'Full Body + Upper/Lower'),

          const SizedBox(height: 25),
          _buildCategoryHeader('🔹 Divisões avançadas / variações'),
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

  // Estilo do botão de cada treino
  Widget _buildSplitCard(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () async {
          // 1. Vai para a tela da API adicionar o exercício
          final exercicioEscolhido = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddWorkoutView()),
          );

          // 2. Se o usuário escolheu um exercício lá na API, essa tela fecha
          // e repassa o exercício lá pra HomeView!
          if (exercicioEscolhido != null && context.mounted) {
            Navigator.pop(context, exercicioEscolhido);
          }
        },
      ),
    );
  }
}