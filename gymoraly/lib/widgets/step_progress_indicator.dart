import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 4, // Padrão de 4 etapas definido aqui
  });

  Widget _buildDash(bool isActive) {
    return Container(
      width: 36, // <-- Deixei os tracinhos mais largos (antes era 24)
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 4), // Espaçamento entre os tracinhos
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1976D2) : const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Garante a centralização na tela pai
      children: [
        // Círculo com o número da etapa atual
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFFE3F2FD),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$currentStep',
            style: const TextStyle(
              color: Color(0xFF1976D2),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 8),
        
        // Gera os tracinhos dinamicamente baseados no totalSteps (4)
        ...List.generate(totalSteps, (index) {
          // Se o índice for menor que o passo atual, o tracinho fica ativo (azul)
          return _buildDash(index < currentStep);
        }),
      ],
    );
  }
}