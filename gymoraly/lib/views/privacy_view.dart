import 'package:flutter/material.dart';

class PrivacyView extends StatefulWidget {
  const PrivacyView({super.key});

  @override
  State<PrivacyView> createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {
  bool isPublic = true; // Estado do Toggle

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER AZUL ---
            _buildHeader(context, "Privacidade", Icons.security_rounded),

            const SizedBox(height: 80),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const Text(
                    "Sua segurança é nossa prioridade",
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 30),

                  // --- CARD DO TOGGLE ---
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: SwitchListTile(
                      activeColor: primaryColor,
                      title: const Text(
                        "Perfil Público",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("Permitir que outros vejam seus treinos"),
                      value: isPublic,
                      onChanged: (value) {
                        setState(() {
                          isPublic = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 100),

                  // --- BOTÃO SALVAR ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Salvar preferências",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para manter o padrão do header
  Widget _buildHeader(BuildContext context, String title, IconData icon) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF2196F3),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 110,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(icon, size: 50, color: const Color(0xFF2196F3)),
          ),
        ),
      ],
    );
  }
}