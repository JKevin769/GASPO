import 'package:flutter/material.dart';
import 'telas/home_tela.dart';

void main() {
  runApp(const GaspoApp());
}

class GaspoApp extends StatelessWidget {
  const GaspoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GASPO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        primaryColor: const Color(0xFF002BFF),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const HomeTela(),
    );
  }
}