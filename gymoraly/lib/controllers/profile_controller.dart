import 'package:flutter/material.dart';
import '../views/login_view.dart';

class ProfileController {
  void logout(BuildContext context) {
    // Aqui você limparia tokens ou variáveis globais se tivesse
    
    // O segredo está no 'pushAndRemoveUntil'
    // Ele remove TODAS as telas anteriores da memória e define o Login como a única
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
      (route) => false, 
    );
  }
}