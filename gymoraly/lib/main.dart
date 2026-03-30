import 'package:flutter/material.dart';
import 'views/login_view.dart'; // Importe o arquivo da view

void main() {
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
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(), // Define a página de login como inicial
    );
  }
}