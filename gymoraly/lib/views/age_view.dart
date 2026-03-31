import 'package:flutter/material.dart';
import 'dart:ui'; // IMPORTANTE: Necessário para o PointerDeviceKind
import '../widgets/step_progress_indicator.dart';
import 'gender_view.dart'; // <-- IMPORTANTE: Importando a tela do Passo 3!

class AgeView extends StatefulWidget {
  const AgeView({super.key});

  @override
  State<AgeView> createState() => _AgeViewState();
}

class _AgeViewState extends State<AgeView> {
  final List<String> months = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];
  final List<int> days = List.generate(31, (index) => index + 1);

  int selectedMonthIndex = 2; // Inicia em Março
  int selectedDayIndex = 28;  // Inicia no dia 29

  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;

  @override
  void initState() {
    super.initState();
    _monthController = FixedExtentScrollController(initialItem: selectedMonthIndex);
    _dayController = FixedExtentScrollController(initialItem: selectedDayIndex);
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  // Componente da Roleta Atualizado
  Widget _buildWheelPicker({
    required int itemCount,
    required Widget Function(int index, bool isSelected) itemBuilder,
    required ValueChanged<int> onSelectedItemChanged,
    required FixedExtentScrollController controller,
    required int selectedIndex,
    required double width,
  }) {
    return SizedBox(
      width: width,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. A Roleta de Fundo (Agora com ScrollConfiguration para o Mouse)
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse, // <-- ISSO AQUI FAZ O MOUSE ARRASTAR NO WINDOWS
              },
            ),
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 52,
              physics: const FixedExtentScrollPhysics(),
              perspective: 0.005,
              overAndUnderCenterOpacity: 0.3,
              onSelectedItemChanged: onSelectedItemChanged,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: itemCount,
                builder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return Center(
                    child: itemBuilder(index, isSelected),
                  );
                },
              ),
            ),
          ),
          
          // 2. A Caixinha Azul desenhada por cima (IgnorePointer para não bloquear o clique)
          IgnorePointer(
            child: Container(
              height: 52,
              width: width,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD).withOpacity(0.4), // Leve transparência
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2196F3), width: 1.5),
              ),
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
              const StepProgressIndicator(currentStep: 2),
              const SizedBox(height: 30),

              const Text(
                'Qual sua idade?',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.black87),
              ),
              const SizedBox(height: 60),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildWheelPicker(
                    width: 140,
                    itemCount: months.length,
                    controller: _monthController,
                    selectedIndex: selectedMonthIndex,
                    onSelectedItemChanged: (index) {
                      setState(() => selectedMonthIndex = index);
                    },
                    itemBuilder: (index, isSelected) {
                      return Text(
                        months[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? Colors.black87 : Colors.grey.shade600,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildWheelPicker(
                    width: 80,
                    itemCount: days.length,
                    controller: _dayController,
                    selectedIndex: selectedDayIndex,
                    onSelectedItemChanged: (index) {
                      setState(() => selectedDayIndex = index);
                    },
                    itemBuilder: (index, isSelected) {
                      return Text(
                        days[index].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? Colors.black87 : Colors.grey.shade600,
                        ),
                      );
                    },
                  ),
                ],
              ),
              
              const Spacer(),

              Row(
                children: [
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
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GenderView()),
                        );
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}