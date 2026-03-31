import 'package:flutter/material.dart';
import '../widgets/step_progress_indicator.dart';
// Lembre-se de importar a próxima tela do Passo 4 quando for criá-la
// import 'physical_data_view.dart'; 

class GenderView extends StatefulWidget {
  const GenderView({super.key});

  @override
  State<GenderView> createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
  // Variável para controlar qual opção está selecionada
  // Usaremos 'male', 'female' ou null (nenhum selecionado inicialmente)
  String? selectedGender = 'male'; // Iniciando com masculino selecionado como na print

  // Widget construtor para os botões de gênero
  Widget _buildGenderCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required String genderValue,
  }) {
    bool isSelected = selectedGender == genderValue;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGender = genderValue;
          });
        },
        child: Container(
          height: 160, // Altura do card
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE3F2FD) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? const Color(0xFF2196F3) : Colors.grey.shade300,
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 70, // Ícone grande
                color: iconColor,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
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
              // Indicador de progresso no Passo 3
              const StepProgressIndicator(currentStep: 3),
              const SizedBox(height: 40),

              // Título
              const Text(
                'Seu Sexo',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.black87),
              ),
              const SizedBox(height: 50),

              // Cards de Seleção de Gênero
              Row(
                children: [
                  // Card Masculino
                  _buildGenderCard(
                    title: 'Masculino',
                    icon: Icons.male,
                    iconColor: const Color(0xFF2196F3), // Azul
                    genderValue: 'male',
                  ),
                  const SizedBox(width: 20), // Espaçamento entre os cards
                  
                  // Card Feminino
                  _buildGenderCard(
                    title: 'Feminino',
                    icon: Icons.female,
                    iconColor: const Color(0xFFAD5287), // Rosa escuro / Vinho
                    genderValue: 'female',
                  ),
                ],
              ),
              
              const Spacer(), // Empurra os botões para baixo

              // Botões de Rodapé
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
                      // Desabilita o botão se nenhuma opção for selecionada
                      onPressed: selectedGender == null 
                        ? null 
                        : () {
                            // Imprimir valor apenas para teste
                            // print('Sexo selecionado: $selectedGender');
                            
                            // Navegar para o passo 4 (ainda vamos criar)
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const PhysicalDataView()));
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