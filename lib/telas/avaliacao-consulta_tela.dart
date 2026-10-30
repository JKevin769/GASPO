import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../widgets/gaspo_header.dart';
import '../widgets/gaspo_bottom_nav.dart';
import 'avaliacao_profissional_tela.dart';

class AvaliacaoConsultaTela extends StatefulWidget {
  const AvaliacaoConsultaTela({super.key});

  @override
  State<AvaliacaoConsultaTela> createState() => _AvaliacaoConsultaTelaState();
}

class _AvaliacaoConsultaTelaState extends State<AvaliacaoConsultaTela> {
  int _estrelasSelecionadas = 3;
  
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horarioController = TextEditingController();
  final TextEditingController _unidadeController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();

  // A máscara de data agora possui filtros ligeiramente mais estritos e será validada durante a digitação
  final _dataMask = MaskTextInputFormatter(
    mask: '##/##/####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy,
  );
  
  // A máscara de horário 
  final _horarioMask = MaskTextInputFormatter(
    mask: '##:##', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy,
  );

  String? _especialidadeSelecionada;
  final List<String> _especialidades = [
    'Cardiologia',
    'Clínico Geral',
    'Odontologia',
    'Ginecologia',
    'Ortopedia',
    'Pediatria'
  ];

  String? _profissionalSelecionado;
  final List<String> _medicosSistema = [
    'Dra. Olivia Silva',
    'Dr. Jonathan Figueredo',
    'Dr. Bruno Almeida',
    'Dra. Larissa Catarina',
    'Dra. Flávia Dávallo',
    'Dr. Matheus Castro'
  ];

  @override
  void dispose() {
    _dataController.dispose();
    _horarioController.dispose();
    _unidadeController.dispose();
    _comentarioController.dispose();
    super.dispose();
  }

  Widget _buildMenuResponsivo(String label, IconData icon, List<String> items, String? selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF1A3B7A)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF1A3B7A), fontWeight: FontWeight.w500),
          prefixIcon: Icon(icon, color: const Color(0xFF1A3B7A)),
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
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildCampoTexto(
    String label, 
    IconData icon, 
    TextEditingController controller, 
    {TextInputType keyboardType = TextInputType.text, MaskTextInputFormatter? formatter, String? hint, bool isDate = false, bool isTime = false}
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: formatter != null ? [formatter] : [],
        onChanged: (value) {
          if (formatter == null) return;
          
          // Validação em Tempo Real para DATA (dia 01-31, mês 01-12)
          if (isDate && value.length >= 2) {
            final unmasked = formatter.getUnmaskedText();
            if (unmasked.length >= 2) {
              int day = int.tryParse(unmasked.substring(0, 2)) ?? 0;
              if (day > 31) {
                controller.text = '31${value.substring(2)}';
                controller.selection = TextSelection.fromPosition(const TextPosition(offset: 2));
              }
              if (day == 0 && unmasked.length > 1) {
                 controller.text = '01${value.substring(2)}';
                 controller.selection = TextSelection.fromPosition(const TextPosition(offset: 2));
              }
            }
            if (unmasked.length >= 4) {
              int month = int.tryParse(unmasked.substring(2, 4)) ?? 0;
              if (month > 12) {
                controller.text = '${value.substring(0, 3)}12${value.length > 5 ? value.substring(5) : ''}';
                controller.selection = TextSelection.fromPosition(const TextPosition(offset: 5));
              }
              if (month == 0 && unmasked.length > 3) {
                 controller.text = '${value.substring(0, 3)}01${value.length > 5 ? value.substring(5) : ''}';
                 controller.selection = TextSelection.fromPosition(const TextPosition(offset: 5));
              }
            }
          }

          // Validação em Tempo Real para HORÁRIO (hora 00-23, min 00-59)
          if (isTime && value.length >= 2) {
             final unmasked = formatter.getUnmaskedText();
             if (unmasked.length >= 2) {
                int hour = int.tryParse(unmasked.substring(0, 2)) ?? 0;
                if (hour > 23) {
                  controller.text = '23${value.substring(2)}';
                  controller.selection = TextSelection.fromPosition(const TextPosition(offset: 2));
                }
             }
             if (unmasked.length >= 4) {
                int minute = int.tryParse(unmasked.substring(2, 4)) ?? 0;
                if (minute > 59) {
                  controller.text = '${value.substring(0, 3)}59';
                  controller.selection = TextSelection.fromPosition(const TextPosition(offset: 5));
                }
             }
          }
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF1A3B7A), fontWeight: FontWeight.w500),
          prefixIcon: Icon(icon, color: const Color(0xFF1A3B7A)),
          hintText: hint, 
          hintStyle: const TextStyle(color: Colors.black26),
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
      ),
    );
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
              const SizedBox(height: 12),
              const Text(
                'Avaliação da Consulta',
                style: TextStyle(fontSize: 19, color: Color(0xFF1A3B7A), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 18),
              
              _buildMenuResponsivo(
                'Especialidade', 
                Icons.medical_services_outlined, 
                _especialidades, 
                _especialidadeSelecionada, 
                (novoValor) => setState(() => _especialidadeSelecionada = novoValor)
              ),
              
              _buildMenuResponsivo(
                'Profissional', 
                Icons.person_outline, 
                _medicosSistema, 
                _profissionalSelecionado, 
                (novoValor) => setState(() => _profissionalSelecionado = novoValor)
              ),
              
              Row(
                children: [
                  Expanded(
                    child: _buildCampoTexto(
                      'Data', 
                      Icons.calendar_today_outlined, 
                      _dataController, 
                      keyboardType: TextInputType.number,
                      formatter: _dataMask,
                      hint: 'dd/mm/aaaa',
                      isDate: true // Ativa as validações de limite de calendário
                    )
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCampoTexto(
                      'Horário', 
                      Icons.access_time, 
                      _horarioController, 
                      keyboardType: TextInputType.number,
                      formatter: _horarioMask,
                      hint: 'hh:mm',
                      isTime: true // Ativa as validações de limite de relógio
                    )
                  ),
                ],
              ),
              
              _buildCampoTexto('Unidade de Saúde', Icons.location_on_outlined, _unidadeController),
              
              const Divider(color: Colors.black26, thickness: 0.8, height: 24),
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
                    hintText: 'Escreva seu comentário sobre a consulta...',
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
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
              const SizedBox(height: 16),
              
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AvaliacaoProfissionalTela()),
                    );
                  },
                  child: const Text('Avançar para Profissional', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                    child: const Text('Cancelar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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