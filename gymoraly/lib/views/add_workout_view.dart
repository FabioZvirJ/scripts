import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 

class AddWorkoutView extends StatefulWidget {
  const AddWorkoutView({super.key});

  @override
  State<AddWorkoutView> createState() => _AddWorkoutViewState();
}

class _AddWorkoutViewState extends State<AddWorkoutView> {
  List<dynamic> _allExercises = []; 
  List<dynamic> _filteredExercises = []; 
  bool _isLoading = true;
  bool _hasError = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchExercisesFromApi(); 
  }

  // ==========================================
  // FUNÇÃO QUE CONECTA NA WGER API (CORRIGIDA)
  // ==========================================
  Future<void> _fetchExercisesFromApi() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      // MUDANÇA AQUI: Usando o endpoint /exerciseinfo/ que traz os nomes legíveis!
      final url = Uri.parse('https://wger.de/api/v2/exerciseinfo/?language=2&limit=50');
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        setState(() {
          _allExercises = data['results']; 
          _filteredExercises = _allExercises; 
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print("Erro ao buscar na API: $e");
    }
  }

  void _filterExercises(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredExercises = _allExercises;
      });
    } else {
      setState(() {
        _filteredExercises = _allExercises.where((exercise) {
          // Garante que não vai dar erro se o nome vier nulo
          final name = (exercise['name'] ?? '').toString().toLowerCase();
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
                onChanged: _filterExercises,
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

          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: primaryColor), 
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

  Widget _buildExerciseCard(dynamic exercise, Color primaryColor) {
    // Agora o campo 'name' vai existir!
    String nomeExercicio = exercise['name'] ?? 'Exercício sem nome';
    
    // Na Wger Info, a categoria é um objeto que contém o nome (ex: "Arms", "Legs")
    String nomeCategoria = 'Músculo indefinido';
    if (exercise['category'] != null && exercise['category']['name'] != null) {
      nomeCategoria = exercise['category']['name'];
    }

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
                  nomeCategoria, // Agora mostra se é braço, perna, peito (em inglês)
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 28),
            color: primaryColor,
            onPressed: () {
              Map<String, String> exercicioEscolhido = {
                'nome': nomeExercicio,
                'grupo': nomeCategoria // Manda a categoria pro card da Home
              };
              
              Navigator.pop(context, exercicioEscolhido);
            },
          ),
        ],
      ),
    );
  }
}