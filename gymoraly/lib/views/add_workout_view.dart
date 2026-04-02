import 'package:flutter/material.dart';

// ==========================================
// SERVIÇO DE API (SIMULADO)
// ==========================================
class WorkoutApiService {
  // Banco de dados simulado (Em um app real, isso viria de um servidor via HTTP)
  final List<Map<String, String>> _mockDatabase = [
    {'nome': 'Supino Reto com Barra', 'grupo': 'Peito', 'dificuldade': 'Intermediário'},
    {'nome': 'Supino Inclinado com Halteres', 'grupo': 'Peito', 'dificuldade': 'Avançado'},
    {'nome': 'Crucifixo na Máquina', 'grupo': 'Peito', 'dificuldade': 'Iniciante'},
    {'nome': 'Agachamento Livre', 'grupo': 'Pernas', 'dificuldade': 'Avançado'},
    {'nome': 'Leg Press 45º', 'grupo': 'Pernas', 'dificuldade': 'Intermediário'},
    {'nome': 'Cadeira Extensora', 'grupo': 'Pernas', 'dificuldade': 'Iniciante'},
    {'nome': 'Puxada Frontal', 'grupo': 'Costas', 'dificuldade': 'Iniciante'},
    {'nome': 'Remada Curvada', 'grupo': 'Costas', 'dificuldade': 'Intermediário'},
    {'nome': 'Rosca Direta com Barra', 'grupo': 'Bíceps', 'dificuldade': 'Iniciante'},
    {'nome': 'Rosca Martelo', 'grupo': 'Bíceps', 'dificuldade': 'Iniciante'},
    {'nome': 'Tríceps Pulley', 'grupo': 'Tríceps', 'dificuldade': 'Iniciante'},
    {'nome': 'Desenvolvimento com Halteres', 'grupo': 'Ombros', 'dificuldade': 'Intermediário'},
  ];

  // Função que "finge" ir na internet buscar os dados
  Future<List<Map<String, String>>> fetchExercises(String query) async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simula o tempo da internet

    if (query.isEmpty) {
      return _mockDatabase; // Retorna tudo se não tiver pesquisa
    }

    // Filtra a lista pelo texto digitado
    return _mockDatabase.where((exercise) {
      final nome = exercise['nome']!.toLowerCase();
      final grupo = exercise['grupo']!.toLowerCase();
      final pesquisa = query.toLowerCase();
      
      return nome.contains(pesquisa) || grupo.contains(pesquisa);
    }).toList();
  }
}

// ==========================================
// TELA PRINCIPAL
// ==========================================
class AddWorkoutView extends StatefulWidget {
  const AddWorkoutView({super.key});

  @override
  State<AddWorkoutView> createState() => _AddWorkoutViewState();
}

class _AddWorkoutViewState extends State<AddWorkoutView> {
  final WorkoutApiService _apiService = WorkoutApiService();
  List<Map<String, String>> _exercises = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadExercises(''); // Carrega a lista inicial ao abrir a tela
  }

  // Função para chamar a API
  void _loadExercises(String query) async {
    setState(() {
      _isLoading = true;
    });

    final results = await _apiService.fetchExercises(query);

    setState(() {
      _exercises = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

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
          'Novo Treino',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // --- BARRA DE PESQUISA ---
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  // Chama a API a cada letra digitada
                  _loadExercises(value);
                },
                decoration: InputDecoration(
                  hintText: 'Buscar exercícios (ex: Peito, Agachamento)',
                  hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          // --- LISTA DE RESULTADOS ---
          Expanded(
            child: _isLoading
                ? const Center(
                    // Mostra a bolinha girando enquanto "baixa" os dados
                    child: CircularProgressIndicator(color: primaryColor),
                  )
                : _exercises.isEmpty
                    ? Center(
                        child: Text(
                          'Nenhum exercício encontrado 😕',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        itemCount: _exercises.length,
                        itemBuilder: (context, index) {
                          final exercise = _exercises[index];
                          return _buildExerciseCard(exercise, primaryColor);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  // --- CARD DE EXERCÍCIO INDIVIDUAL ---
  Widget _buildExerciseCard(Map<String, String> exercise, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Ícone do exercício
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(Icons.fitness_center, color: primaryColor),
          ),
          const SizedBox(width: 15),
          
          // Textos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise['nome']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      exercise['grupo']!,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                    const Text(' • ', style: TextStyle(color: Colors.grey)),
                    Text(
                      exercise['dificuldade']!,
                      style: TextStyle(color: primaryColor, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Botão Adicionar
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 28),
            color: primaryColor,
            onPressed: () {
              // FECHA A TELA E MANDA O EXERCÍCIO DE VOLTA PRA HOME!
              Navigator.pop(context, exercise);
            },
          ),
        ],
      ),
    );
  }
}