import 'package:flutter/material.dart';

class NotificationsSettingsView extends StatefulWidget {
  const NotificationsSettingsView({super.key});

  @override
  State<NotificationsSettingsView> createState() => _NotificationsSettingsViewState();
}

class _NotificationsSettingsViewState extends State<NotificationsSettingsView> {
  bool pushEnabled = true;
  bool workoutReminders = true;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, "Notificações", Icons.notifications_active_rounded),
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                _buildSwitchCard("Notificações Push", pushEnabled, (val) => setState(() => pushEnabled = val)),
                const SizedBox(height: 15),
                _buildSwitchCard("Lembretes de Treino", workoutReminders, (val) => setState(() => workoutReminders = val)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchCard(String title, bool value, Function(bool) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: SwitchListTile(
        activeColor: const Color(0xFF2196F3),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        value: value,
        onChanged: onChanged,
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
          decoration: const BoxDecoration(color: Color(0xFF2196F3), borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          child: SafeArea(child: Row(children: [IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)), Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))])),
        ),
        Positioned(top: 110, child: Container(padding: const EdgeInsets.all(15), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)]), child: Icon(icon, size: 50, color: const Color(0xFF2196F3)))),
      ],
    );
  }
}