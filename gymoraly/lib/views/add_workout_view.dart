import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Importação para usar a internet

class AddWorkoutView extends StatefulWidget {
  const AddWorkoutView({super.key});

  @override
  State<AddWorkoutView> createState() => _AddWorkoutViewState();
}

class _AddWorkoutViewState extends State<AddWorkoutView> {
  List<dynamic> _allExercises = []; // Guarda todos os exercícios baixados
  List<dynamic> _filteredExercises = []; // Guarda os exercícios filtrados pela pesquisa
  bool _isLoading = true;
  bool _hasError = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchExercisesFromApi(); // Chama a API assim que a tela abre
  }

  // ==========================================
  // FUNÇÃO QUE CONECTA NA WGER API
  // ==========================================
  Future<void> _fetchExercisesFromApi() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      // Endpoint da Wger API (language=2 é Inglês, limit=50 para não pesar muito)
      final url = Uri.parse('https://wger.de/api/v2/exercise/?language=2&limit=50');
      
      // Fazendo o GET na internet
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Se a internet respondeu "OK" (200), vamos decodificar o JSON
        final data = json.decode(response.body);
        
        setState(() {
          _allExercises = data['results']; // 'results' é onde a Wger guarda a lista
          _filteredExercises = _allExercises; // Inicialmente, mostra todos
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      // Cai aqui se estiver sem internet, por exemplo
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print("Erro ao buscar na API: $e");
    }
  }

  // Função para filtrar a lista no celular (sem gastar dados da API toda hora)
  void _filterExercises(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredExercises = _allExercises;
      });
    } else {
      setState(() {
        _filteredExercises = _allExercises.where((exercise) {
          final name = exercise['name'].toString().toLowerCase();
          return name.contains(query.toLowerCase());
        }).toList();
      });
    }
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
          'Adicionar Exercício',
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
                onChanged: _filterExercises, // Filtra enquanto digita
                decoration: InputDecoration(
                  hintText: 'Buscar exercícios (ex: Curl, Press)',
                  hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          // --- LISTA DE RESULTADOS DA API ---
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: primaryColor), // Carregando...
                  )
                : _hasError
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.wifi_off, size: 50, color: Colors.grey),
                            const SizedBox(height: 10),
                            const Text('Erro ao conectar na API.', style: TextStyle(color: Colors.grey)),
                            TextButton(
                              onPressed: _fetchExercisesFromApi,
                              child: const Text('Tentar novamente'),
                            )
                          ],
                        ),
                      )
                    : _filteredExercises.isEmpty
                        ? Center(
                            child: Text(
                              'Nenhum exercício encontrado 😕',
                              style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            itemCount: _filteredExercises.length,
                            itemBuilder: (context, index) {
                              final exercise = _filteredExercises[index];
                              return _buildExerciseCard(exercise, primaryColor);
                            },
                          ),
          ),
        ],
      ),
    );
  }

  // --- CARD DE EXERCÍCIO DA API ---
  Widget _buildExerciseCard(dynamic exercise, Color primaryColor) {
    // A Wger retorna o nome do exercício no campo 'name'
    String nomeExercicio = exercise['name'] ?? 'Nome desconhecido';

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
                  nomeExercicio,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  'Banco de Dados Wger', // A API Wger retorna IDs de categoria, não nomes, então deixei genérico
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          
          // Botão Adicionar
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 28),
            color: primaryColor,
            onPressed: () {
              // Devolve um mapa limpo para a tela anterior
              Map<String, String> exercicioEscolhido = {
                'nome': nomeExercicio,
                'grupo': 'Exercício API'
              };
              
              // Fecha a tela e manda os dados
              Navigator.pop(context, exercicioEscolhido);
            },
          ),
        ],
      ),
    );
  }
}