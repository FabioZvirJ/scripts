import 'package:flutter/material.dart';
import 'package:flag/flag.dart'; // Importando o pacote de bandeiras

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  // Idioma selecionado por padrão
  String selectedLanguage = 'Português (Brasil)';

  // Controlador obrigatório para o Scrollbar funcionar sem erros
  final ScrollController _scrollController = ScrollController();

  // Lista de idiomas agora usando o código do país em vez de emojis
  final List<Map<String, String>> languages = [
    {'name': 'Português (Brasil)', 'code': 'BR'},
    {'name': 'English (US)', 'code': 'US'},
    {'name': 'Español', 'code': 'ES'},
    {'name': 'Français', 'code': 'FR'},
    {'name': 'Deutsch', 'code': 'DE'},
    {'name': 'Italiano', 'code': 'IT'},
    {'name': '日本語', 'code': 'JP'},
    {'name': '中文', 'code': 'CN'},
    {'name': '한국어', 'code': 'KR'},
    {'name': 'Русский', 'code': 'RU'},
    {'name': 'Português (Portugal)', 'code': 'PT'},
    {'name': 'English (UK)', 'code': 'GB'},
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // --- HEADER AZUL PADRÃO ---
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        'Idioma',
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 24, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 110,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
                  ),
                  child: const Icon(Icons.language_rounded, size: 50, color: primaryColor),
                ),
              ),
            ],
          ),

          const SizedBox(height: 80),

          // --- LISTA DE IDIOMAS COM SCROLLBAR E FLAGS ---
          Expanded(
            child: Scrollbar(
              controller: _scrollController, 
              thumbVisibility: true,         
              thickness: 6,
              radius: const Radius.circular(10),
              child: ListView.builder(
                controller: _scrollController, 
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final lang = languages[index];
                  final isSelected = selectedLanguage == lang['name'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLanguage = lang['name']!;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withOpacity(0.05) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Nome do Idioma
                          Expanded(
                            child: Text(
                              lang['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? primaryColor : Colors.black87,
                              ),
                            ),
                          ),
                          
                          // Bandeira usando o pacote 'flag'
                          Flag.fromString(
                            lang['code']!,
                            height: 24,
                            width: 32,
                            borderRadius: 4, // Dá uma borda levemente arredondada na bandeira
                            fit: BoxFit.cover,
                          ),
                          
                          const SizedBox(width: 15),
                          
                          // Ícone de Seleção (Check)
                          Icon(
                            isSelected ? Icons.check_circle : Icons.circle_outlined,
                            color: isSelected ? primaryColor : Colors.grey.shade300,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // --- BOTÃO CONFIRMAR ---
          Padding(
            padding: const EdgeInsets.all(25),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Aqui você pode salvar o idioma escolhido no seu banco de dados/estado
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                child: const Text(
                  "Confirmar",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}