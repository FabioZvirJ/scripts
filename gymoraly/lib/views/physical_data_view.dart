import 'package:flutter/material.dart';
import '../widgets/step_progress_indicator.dart';
import '../controllers/register_controller.dart'; 

class PhysicalDataView extends StatefulWidget {
  final RegisterController controller; // Recebe o controller com os dados dos passos 1, 2 e 3
  
  const PhysicalDataView({super.key, required this.controller});

  @override
  State<PhysicalDataView> createState() => _PhysicalDataViewState();
}

class _PhysicalDataViewState extends State<PhysicalDataView> {
  final TextEditingController _heightController = TextEditingController(text: '175');
  final TextEditingController _weightController = TextEditingController(text: '70');

  double _currentHeight = 175.0;

  @override
  void initState() {
    super.initState();
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

  // CORREÇÃO: Adicionado o "return" com a estrutura do campo de texto
  Widget _buildSmallInput({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold, 
            color: Colors.black54
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // Envolvemos o body no ListenableBuilder para mostrar o Loading circular do botão
      body: ListenableBuilder(
        listenable: widget.controller,
        builder: (context, child) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: StepProgressIndicator(currentStep: 4)),
                  const SizedBox(height: 30),

                  const Text(
                    'Seus Dados\nAtuais',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black87, height: 1.2),
                  ),
                  const SizedBox(height: 40),

                  _buildSmallInput(
                    label: 'Altura (cm)',
                    controller: _heightController,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildSmallInput(
                    label: 'Peso (kg)',
                    controller: _weightController,
                  ),

                  const SizedBox(height: 80), 

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
                      
                      // BOTAO CADASTRAR FINAL AQUI!
                      Expanded(
                        child: ElevatedButton(
                          // Se estiver carregando (isLoading), desabilita o botão (null)
                          onPressed: widget.controller.isLoading ? null : () {
                            // 1. Salva a altura e peso do Passo 4 no model do Controller
                            widget.controller.model.height = double.tryParse(_heightController.text) ?? 0.0;
                            widget.controller.model.weight = double.tryParse(_weightController.text) ?? 0.0;
                            
                            // 2. Dispara a função de registro (que vai salvar no SQLite)
                            widget.controller.register(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          // Mostra o loading ou o texto
                          child: widget.controller.isLoading 
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Text('Cadastrar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}