import 'package:flutter/material.dart';

class SubscriptionsView extends StatelessWidget {
  const SubscriptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, "Assinaturas", Icons.stars_rounded),
          const SizedBox(height: 80),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              children: [
                _buildPlanCard(primaryColor, "Plano Premium", "Ativo", true),
                const SizedBox(height: 20),
                const Text("Vantagens inclusas:", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _benefitRow("Acesso ilimitado a treinos"),
                _benefitRow("Gráficos de progresso"),
                _benefitRow("Sem anúncios"),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
                IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        Positioned(top: 110, child: Container(padding: const EdgeInsets.all(15), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(icon, size: 50, color: const Color(0xFF2196F3)))),
      ],
    );
  }

  Widget _buildPlanCard(Color color, String name, String status, bool active) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(status, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
          ]),
          const Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
    );
  }

  Widget _benefitRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(children: [const Icon(Icons.check, size: 18, color: Colors.blue), const SizedBox(width: 10), Text(text)]),
    );
  }
}