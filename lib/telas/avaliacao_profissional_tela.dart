import 'package:flutter/material.dart';
import '../widgets/gaspo_header.dart';
import '../widgets/gaspo_bottom_nav.dart';
import 'home_tela.dart';

class AvaliacaoProfissionalTela extends StatefulWidget {
  // Parâmetro opcional para receber o médico selecionado na tela anterior
  final String? medicoPreSelecionado;
  
  const AvaliacaoProfissionalTela({super.key, this.medicoPreSelecionado});

  @override
  State<AvaliacaoProfissionalTela> createState() => _AvaliacaoProfissionalTelaState();
}

class _AvaliacaoProfissionalTelaState extends State<AvaliacaoProfissionalTela> {
  int _estrelasSelecionadas = 3;
  final TextEditingController _comentarioController = TextEditingController();

  String? _medicoSelecionado;
  final List<String> _medicosSistema = [
    'Dra. Olivia Silva',
    'Dr. Jonathan Figueredo',
    'Dr. Bruno Almeida',
    'Dra. Larissa Catarina',
    'Dra. Flávia Dávallo',
    'Dr. Matheus Castro'
  ];

  @override
  void initState() {
    super.initState();
    // Se o médico foi preenchido na tela de avaliação da consulta, ele já vem selecionado aqui
    if (widget.medicoPreSelecionado != null && _medicosSistema.contains(widget.medicoPreSelecionado)) {
      _medicoSelecionado = widget.medicoPreSelecionado;
    }
  }

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GaspoHeader(),
              const SizedBox(height: 16),
              const Text(
                'Avaliação do Profissional',
                style: TextStyle(fontSize: 19, color: Color(0xFF1A3B7A), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const Text(
                'Informações do Profissional',
                style: TextStyle(fontSize: 15, color: Color(0xFF1A3B7A), fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _medicoSelecionado,
                icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF1A3B7A)),
                decoration: InputDecoration(
                  labelText: 'Selecione o Médico',
                  labelStyle: const TextStyle(color: Color(0xFF1A3B7A)),
                  prefixIcon: const Icon(Icons.badge_outlined, color: Color(0xFF1A3B7A)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                ),
                items: _medicosSistema.map((String medico) {
                  return DropdownMenuItem<String>(
                    value: medico,
                    child: Text(medico, style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
                onChanged: (novoValor) {
                  setState(() {
                    _medicoSelecionado = novoValor;
                  });
                },
              ),
              
              const SizedBox(height: 24),
              const Divider(height: 1, color: Colors.black26),
              const SizedBox(height: 24),
              
              const Text(
                'Adicionar Comentário',
                style: TextStyle(fontSize: 15, color: Color(0xFF1A3B7A), fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E6E6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _comentarioController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.chat_bubble, color: Color(0xFF002BFF)),
                    hintText: 'Como foi o atendimento do profissional?',
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () => setState(() => _estrelasSelecionadas = index + 1),
                    icon: Icon(
                      Icons.star,
                      size: 44,
                      color: index < _estrelasSelecionadas ? const Color(0xFFFFB321) : const Color(0xFFD2D2D2),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF002BFF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Avaliação enviada com sucesso!')),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeTela()),
                      (route) => false,
                    );
                  },
                  child: const Text('Enviar Avaliação Final', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              
              Center(
                child: SizedBox(
                  width: 260,
                  height: 42,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDCE2F0),
                      foregroundColor: const Color(0xFF0055D4),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Voltar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GaspoBottomNav(currentIndex: 0),
    );
  }
}