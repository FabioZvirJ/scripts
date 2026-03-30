import 'dart:io'; // Necessário para verificar a plataforma
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; 
import 'views/login_view.dart';

void main() {
  // 1. Garante a inicialização dos serviços do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Configuração específica para rodar no Windows, macOS ou Linux
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gymoraly',
      theme: ThemeData(
        useMaterial3: true,
        // Cor primária baseada no seu logo azul
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          primary: const Color(0xFF2196F3),
        ),
      ),
      home: const LoginView(),
    );
  }
}