import 'package:flutter/material.dart';
import 'package:gymoraly/controllers/register_controller.dart';
import 'dart:ui';
import '../widgets/step_progress_indicator.dart';
import 'gender_view.dart';

class AgeView extends StatefulWidget {
  final RegisterController controller;
  const AgeView({super.key, required this.controller});

  @override
  State<AgeView> createState() => _AgeViewState();
}

class _AgeViewState extends State<AgeView> {
  final List<String> months = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];
  final List<int> days = List.generate(31, (index) => index + 1);
  // Anos de 1940 até o ano atual
  final List<int> years = List.generate(DateTime.now().year - 1939, (index) => DateTime.now().year - index);

  int selectedMonthIndex = 2; // Inicia em Março
  int selectedDayIndex = 28;  // Inicia no dia 29
  int selectedYearIndex = 30; // Index inicial para um ano qualquer da lista
  int _calculatedAge = 0;     // Variável que vai guardar a idade calculada

  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _yearController;

  @override
  void initState() {
    super.initState();
    _monthController = FixedExtentScrollController(initialItem: selectedMonthIndex);
    _dayController = FixedExtentScrollController(initialItem: selectedDayIndex);
    _yearController = FixedExtentScrollController(initialItem: selectedYearIndex);
    
    // Calcula a idade inicial ao abrir a tela
    _calculateAge();
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  // Função para calcular a idade real baseada na data escolhida
  void _calculateAge() {
    final now = DateTime.now();
    final birthMonth = selectedMonthIndex + 1; // +1 porque os meses na lista começam no index 0
    final birthDay = days[selectedDayIndex];
    final birthYear = years[selectedYearIndex];

    int age = now.year - birthYear;
    
    // Se ainda não chegou o mês do aniversário, ou se está no mês mas não chegou o dia, tira 1 ano
    if (now.month < birthMonth || (now.month == birthMonth && now.day < birthDay)) {
      age--;
    }

    setState(() {
      _calculatedAge = age;
    });
  }

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
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 52,
              physics: const FixedExtentScrollPhysics(),
              perspective: 0.005,
              overAndUnderCenterOpacity: 0.3,
              onSelectedItemChanged: (index) {
                onSelectedItemChanged(index);
                _calculateAge(); // Recalcula a idade sempre que rolar alguma roleta
              },
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
          IgnorePointer(
            child: Container(
              height: 52,
              width: width,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD).withOpacity(0.4),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Diminuí o padding lateral para caber as 3 roletas
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

              // ÁREA DAS ROLETAS (Agora com Mês, Dia e Ano)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Mês
                  _buildWheelPicker(
                    width: 120, // Ajustado para caber o ano
                    itemCount: months.length,
                    controller: _monthController,
                    selectedIndex: selectedMonthIndex,
                    onSelectedItemChanged: (index) => setState(() => selectedMonthIndex = index),
                    itemBuilder: (index, isSelected) {
                      return Text(
                        months[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? Colors.black87 : Colors.grey.shade600,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  
                  // Dia
                  _buildWheelPicker(
                    width: 60, // Ajustado para caber o ano
                    itemCount: days.length,
                    controller: _dayController,
                    selectedIndex: selectedDayIndex,
                    onSelectedItemChanged: (index) => setState(() => selectedDayIndex = index),
                    itemBuilder: (index, isSelected) {
                      return Text(
                        days[index].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? Colors.black87 : Colors.grey.shade600,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),

                  // Ano
                  _buildWheelPicker(
                    width: 80,
                    itemCount: years.length,
                    controller: _yearController,
                    selectedIndex: selectedYearIndex,
                    onSelectedItemChanged: (index) => setState(() => selectedYearIndex = index),
                    itemBuilder: (index, isSelected) {
                      return Text(
                        years[index].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? Colors.black87 : Colors.grey.shade600,
                        ),
                      );
                    },
                  ),
                ],
              ),
              
              // Mostra a idade calculada como no print
              const SizedBox(height: 30),
              Column(
                children: [
                  const Text('Idade', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_calculatedAge anos',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
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
                        // Verifica se a idade é válida (Ex: se ele tentou criar uma data futura ou muito pequeno)
                        if (_calculatedAge < 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Você precisa ter pelo menos 10 anos.')),
                          );
                          return;
                        }

                        // Salva a idade calculada no model do Controller
                        widget.controller.model.age = _calculatedAge;
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // Passa o controller para frente!
                            builder: (context) => GenderView(controller: widget.controller),
                          ),
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