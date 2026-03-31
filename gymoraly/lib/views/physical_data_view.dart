import 'package:flutter/material.dart';
import '../widgets/step_progress_indicator.dart';

class PhysicalDataView extends StatefulWidget {
  const PhysicalDataView({super.key});

  @override
  State<PhysicalDataView> createState() => _PhysicalDataViewState();
}

class _PhysicalDataViewState extends State<PhysicalDataView> {
  // Controladores para os campos de texto
  final TextEditingController _heightController = TextEditingController(text: '175');
  final TextEditingController _weightController = TextEditingController(text: '70');

  // Variável de estado para o Slider acompanhar a altura
  double _currentHeight = 175.0;

  @override
  void initState() {
    super.initState();
    // Adiciona listener para caso o usuário digite a altura manualmente
    _heightController.addListener(() {
      final value = double.tryParse(_heightController.text);
      if (value != null && value >= 100 && value <= 250) {
        setState(() {
          _currentHeight = value;
        });
      }
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  // Helper para os inputs menores dessa tela
  Widget _buildSmallInput({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 52,
          width: 100, // Largura restrita para caber o boneco do lado
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF2196F3), width: 1.5),
              ),
            ),
          ),
        ),
      ],
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Indicador de progresso (Passo 4 - Final)
              const Center(child: StepProgressIndicator(currentStep: 4)),
              const SizedBox(height: 30),

              const Text(
                'Seus Dados\nAtuais',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black87, height: 1.2),
              ),
              const SizedBox(height: 40),

              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Coluna da Esquerda (Inputs Altura e Peso)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSmallInput(
                          label: 'Altura (cm)',
                          controller: _heightController,
                        ),
                        const SizedBox(height: 40),
                        _buildSmallInput(
                          label: 'Peso (kg)',
                          controller: _weightController,
                        ),
                      ],
                    ),
                    
                    const SizedBox(width: 20),

                    // Boneco Neutro
                    Expanded(
                      child: Center(
                        child: Icon(
                          Icons.accessibility_new_rounded,
                          size: 220,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),

                    // Coluna da Direita (Caixinha flutuante e Slider Vertical)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Caixinha com o valor atual do Slider
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _currentHeight.toInt().toString(),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Slider Vertical (Rotacionado)
                        SizedBox(
                          height: 250,
                          child: RotatedBox(
                            quarterTurns: 3, // Gira o slider para ficar vertical
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 6.0,
                                activeTrackColor: primaryColor,
                                inactiveTrackColor: Colors.grey.shade200,
                                thumbColor: primaryColor,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                overlayColor: primaryColor.withOpacity(0.2),
                              ),
                              child: Slider(
                                value: _currentHeight,
                                min: 100, // Altura mínima 1m
                                max: 250, // Altura máxima 2.5m
                                onChanged: (value) {
                                  setState(() {
                                    _currentHeight = value;
                                    // Atualiza o campo de texto automaticamente
                                    _heightController.text = value.toInt().toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
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
                        // Ação final! Enviar os dados para a API/Controller e finalizar o cadastro
                        // print('Altura: ${_heightController.text}, Peso: ${_weightController.text}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Cadastrar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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