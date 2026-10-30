import 'package:flutter/material.dart';
import '../widgets/gaspo_header.dart';
import '../widgets/gaspo_bottom_nav.dart';
import 'detalhes_profissional_tela.dart'; // Importando a nova tela

class EspecialistasTela extends StatelessWidget {
  const EspecialistasTela({super.key});

  // Lista simulada com o novo atributo 'status'
  final List<Map<String, String>> especialistas = const [
    {'nome': 'Dra. Olivia Silva', 'especialidade': 'Cardiologista', 'nota': '4.9 (37 Reviews)', 'status': 'Presente'},
    {'nome': 'Dr. Jonathan Figueredo', 'especialidade': 'Dentista', 'nota': '4.9 (37 Reviews)', 'status': 'Ocupado'},
    {'nome': 'Dr. Bruno Almeida', 'especialidade': 'Ortopedista', 'nota': '4.9 (37 Reviews)', 'status': 'Ausente'},
    {'nome': 'Dra. Larissa Catarina', 'especialidade': 'Ginecologista e Pediatra', 'nota': '4.9 (37 Reviews)', 'status': 'Presente'},
    {'nome': 'Dra. Flávia Dávallo', 'especialidade': 'Ortopedista', 'nota': '4.9 (37 Reviews)', 'status': 'Ocupado'},
    {'nome': 'Dr. Matheus Castro', 'especialidade': 'Clínico Geral', 'nota': '4.9 (37 Reviews)', 'status': 'Presente'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GaspoHeader(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                'Especialistas',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF1A3B7A),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Divider(height: 1, color: Colors.black12),
            Expanded(
              child: ListView.separated(
                itemCount: especialistas.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.black12),
                itemBuilder: (context, index) {
                  final item = especialistas[index];
                  return InkWell(
                    onTap: () {
                      // Agora navega para a tela de Detalhes, passando os dados do médico
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetalhesProfissionalTela(
                            nome: item['nome']!,
                            especialidade: item['especialidade']!,
                            status: item['status']!,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blueGrey[100],
                            child: const Icon(Icons.person, size: 34, color: Colors.blueGrey),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['nome']!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item['especialidade']!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      item['nota']!,
                                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const GaspoBottomNav(currentIndex: 0),
    );
  }
}