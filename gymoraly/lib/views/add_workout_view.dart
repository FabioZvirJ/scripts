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

  Future<void> _fetchExercisesFromApi() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final url = Uri.parse('https://exercisedb.dev/api/v1/exercises?limit=100');
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        if (jsonResponse['success'] == true) {
          final List<dynamic> data = jsonResponse['data'];
          
          setState(() {
            data.shuffle(); 
            _allExercises = data; 
            _filteredExercises = _allExercises; 
            _isLoading = false;
          });
        } else {
          throw Exception("API retornou success: false");
        }
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
          final name = (exercise['name'] ?? '').toString().toLowerCase();
          
          final bodyPartsList = exercise['bodyParts'] as List<dynamic>? ?? [];
          final bodyPart = bodyPartsList.isNotEmpty ? bodyPartsList.first.toString().toLowerCase() : '';
          
          return name.contains(query.toLowerCase()) || bodyPart.contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  String _traduzirGrupo(String bodyPartIngles) {
    switch (bodyPartIngles.toLowerCase()) {
      case 'back': return 'Costas';
      case 'cardio': return 'Cardio';
      case 'chest': return 'Peito';
      case 'lower arms': return 'Antebraços';
      case 'lower legs': return 'Panturrilhas';
      case 'neck': return 'Pescoço';
      case 'shoulders': return 'Ombros';
      case 'upper arms': return 'Braços';
      case 'upper legs': return 'Pernas';
      case 'waist': return 'Abdômen';
      default: return bodyPartIngles;
    }
  }

  // ==========================================
  // FUNÇÃO DO POP-UP (DIALOG) DO GIF
  // ==========================================
  void _mostrarGifExpandido(String gifUrl, String nome) {
    if (gifUrl.isEmpty) return; // Se não tiver GIF, nem abre

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ocupa só o espaço necessário
          children: [
            // Cabeçalho com Nome e botão de Fechar
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      nome,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context), // Fecha o pop-up
                  ),
                ],
              ),
            ),
            const Divider(), // Linha divisória
            
            // O GIF Gigante!
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              child: Image.network(
                gifUrl,
                width: double.infinity,
                fit: BoxFit.contain, // Ajusta o GIF para caber certinho sem cortar
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  // Mostra bolinha de carregamento enquanto o GIF grande baixa
                  return const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: CircularProgressIndicator(color: Color(0xFF2196F3)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
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
                  hintText: 'Buscar exercícios (ex: press, squat, pernas)',
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
                ? const Center(child: CircularProgressIndicator(color: primaryColor))
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
    String nomeCru = exercise['name'] ?? '';
    String nomeExercicio = nomeCru.isNotEmpty ? nomeCru[0].toUpperCase() + nomeCru.substring(1) : 'Exercício sem nome';
    String gifUrl = exercise['gifUrl'] ?? '';
    
    List<dynamic> bodyPartsList = exercise['bodyParts'] ?? [];
    String nomeCategoria = 'Geral';
    if (bodyPartsList.isNotEmpty) {
      nomeCategoria = _traduzirGrupo(bodyPartsList.first.toString());
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
          // AQUI: ADICIONAMOS O CLIQUE NA IMAGEM!
          MouseRegion(
            cursor: SystemMouseCursors.click, // Aparece a mãozinha no Windows/Web
            child: GestureDetector(
              onTap: () {
                // Chama a função que abre o Pop-up
                _mostrarGifExpandido(gifUrl, nomeExercicio);
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade100)
                ),
                clipBehavior: Clip.antiAlias,
                child: gifUrl.isNotEmpty 
                    ? Image.network(
                        gifUrl, 
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.fitness_center, color: primaryColor),
                      )
                    : Icon(Icons.fitness_center, color: primaryColor),
              ),
            ),
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
                  nomeCategoria, 
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
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
                'grupo': nomeCategoria 
              };
              
              Navigator.pop(context, exercicioEscolhido);
            },
          ),
        ],
      ),
    );
  }
}