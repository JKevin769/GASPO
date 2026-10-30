import 'package:flutter/material.dart';
import '../widgets/gaspo_header.dart';
import '../widgets/gaspo_bottom_nav.dart';

class DetalhesProfissionalTela extends StatelessWidget {
  final String nome;
  final String especialidade;
  final String status;

  const DetalhesProfissionalTela({
    super.key,
    required this.nome,
    required this.especialidade,
    required this.status,
  });

  // Função para definir a cor da bolinha e da borda baseado no status
  Color _obterCorStatus() {
    switch (status.toLowerCase()) {
      case 'presente':
        return Colors.green;
      case 'ocupado':
        return Colors.orange;
      case 'ausente':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final corStatus = _obterCorStatus();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const GaspoHeader(),
            const SizedBox(height: 30),
            
            // Foto do Profissional
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: corStatus, width: 3),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueGrey[100],
                child: const Icon(Icons.person, size: 60, color: Colors.blueGrey),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Nome do Profissional
            Text(
              nome,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A3B7A),
              ),
            ),
            
            const SizedBox(height: 6),
            
            // Especialidade
            Text(
              especialidade,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Badge / Tag de Status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: corStatus.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: corStatus),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: corStatus,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: corStatus,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Botão de Voltar Opcional no corpo
            SizedBox(
              width: 200,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002BFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Voltar para a Lista',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const GaspoBottomNav(currentIndex: 0),
    );
  }
}