import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER AZUL ---
            Container(
              height: 180,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              padding: const EdgeInsets.only(top: 60, left: 25),
              child: const Text(
                'Progresso',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // --- CARD PRINCIPAL DE GRÁFICOS ---
            Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sessão de treino',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      
                      // Placeholder do Gráfico de Linha (Simulado)
                      SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: CustomPaint(painter: LineChartPainter()),
                      ),
                      
                      const SizedBox(height: 10),
                      // Dias da semana
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Seg', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text('Ter', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text('Qua', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text('Qui', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text('Sáb', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text('Dom', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      
                      const Divider(height: 40),

                      const Text(
                        'Evolução semanal',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),

                      // Gráfico de Barras (Simulado)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildBar(40), _buildBar(70), _buildBar(50), 
                          _buildBar(90, isSelected: true), _buildBar(30), 
                          _buildBar(60), _buildBar(45), _buildBar(80),
                        ],
                      ),

                      const Divider(height: 40),

                      const Text(
                        'Sugestões de evolução',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),

                      // Lista de Recomendações
                      _buildRecommendationItem(
                        Icons.trending_up, 
                        'Aumente 5% no supino', 
                        'Banco inclinado', 
                        Colors.blue.shade50, 
                        primaryColor
                      ),
                      const SizedBox(height: 15),
                      _buildRecommendationItem(
                        Icons.timer_outlined, 
                        'Reduzir descanso para 1:20 min', 
                        'Todos os exercícios', 
                        Colors.blue.shade50, 
                        primaryColor
                      ),

                      const SizedBox(height: 30),

                      // Botão Ver Relatório
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Ver relatório completo',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para as barras do gráfico
  Widget _buildBar(double height, {bool isSelected = false}) {
    return Container(
      width: 12,
      height: height,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2196F3) : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // Widget para os itens de sugestão
  Widget _buildRecommendationItem(IconData icon, String title, String subtitle, Color bgColor, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        )
      ],
    );
  }
}

// Pintor customizado para simular a linha curva do gráfico
class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2196F3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.2, size.width * 0.4, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.9, size.width * 0.8, size.height * 0.6);
    path.lineTo(size.width, size.height * 0.65);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}