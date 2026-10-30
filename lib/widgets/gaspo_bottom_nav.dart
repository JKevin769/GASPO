import 'package:flutter/material.dart';
import '../telas/home_tela.dart';

class GaspoBottomNav extends StatelessWidget {
  final int currentIndex;
  const GaspoBottomNav({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF002BFF),
      unselectedItemColor: Colors.black87,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
      onTap: (index) {
        if (index == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeTela()),
            (route) => false,
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Início'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'Agendar'),
        BottomNavigationBarItem(icon: Icon(Icons.description_outlined), label: 'Histórico'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
      ],
    );
  }
}