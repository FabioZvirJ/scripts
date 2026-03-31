import 'package:flutter/material.dart';
import '../widgets/step_progress_indicator.dart';

class AgeView extends StatefulWidget {
  const AgeView({super.key});

  @override
  State<AgeView> createState() => _AgeViewState();
}

class _AgeViewState extends State<AgeView> {
  // Dados fictícios para o visual (você pode conectar isso ao seu RegisterController depois)
  final List<String> months = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];
  final List<int> days = List.generate(31, (index) => index + 1);

  int selectedMonthIndex = 2; // Começa em Março, por exemplo
  int selectedDayIndex = 28;  // Começa no dia 29
  int calculatedAge = 10;     // Idade (pode ser calculada dinamicamente depois)

  // Helper para construir as "Roletas" (Wheels)
  Widget _buildWheelPicker({
    required int itemCount,
    required Widget Function(int index, bool isSelected) itemBuilder,
    required ValueChanged<int> onSelectedItemChanged,
    required int initialItem,
    double width = 100,
  }) {
    return SizedBox(
      width: width,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Caixinha azul de fundo (seleção)
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2196F3), width: 1.5),
            ),
          ),
          // A roleta rolável
          ListWheelScrollView.useDelegate(
            itemExtent: 48,
            physics: const FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(initialItem: initialItem),
            onSelectedItemChanged: onSelectedItemChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: itemCount,
              builder: (context, index) {
                // Checa se é o item selecionado atualmente para mudar a cor
                bool isSelected = initialItem == index;
                return Center(
                  child: itemBuilder(index, isSelected),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
              padding: const EdgeInsets.only(right: 2),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Indicador no Passo 2
              const StepProgressIndicator(currentStep: 2),
              const SizedBox(height: 30),

              // Título
              const Text(
                'Qual sua idade?',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.black87),
              ),
              const SizedBox(height: 60),

              // Área dos Pickers e Idade
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Picker de Mês
                  _buildWheelPicker(
                    width: 120,
                    itemCount: months.length,
                    initialItem: selectedMonthIndex,
                    onSelectedItemChanged: (index) {
                      setState(() => selectedMonthIndex = index);
                    },
                    itemBuilder: (index, isSelected) {
                      return Text(
                        months[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? Colors.black87 : Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),

                  // Picker de Dia
                  _buildWheelPicker(
                    width: 70,
                    itemCount: days.length,
                    initialItem: selectedDayIndex,
                    onSelectedItemChanged: (index) {
                      setState(() => selectedDayIndex = index);
                    },
                    itemBuilder: (index, isSelected) {
                      return Text(
                        days[index].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? Colors.black87 : Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),

                  // Caixinha da Idade (Visual)
                  Column(
                    children: [
                      const Text(
                        'Idade',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 70,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          calculatedAge.toString(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // Espaçador para jogar os botões para o final da tela
              const Spacer(),

              // Botões "Anterior" e "Próximo"
              Row(
                children: [
                  // Botão Anterior
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Anterior', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Botão Próximo
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navegue para a View do Passo 3 (Identificação) aqui
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Próximo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Margem segura na parte inferior
            ],
          ),
        ),
      ),
    );
  }
}