import 'package:flutter/material.dart';
import 'package:beach_rent/dominio/dto/dto_quadra.dart';
import 'package:beach_rent/banco/sqlite/dao_quadra.dart';
import 'lista_quadra.dart'; // Certifique-se de importar a página da lista de quadras

class FormQuadra extends StatefulWidget {
  const FormQuadra({super.key});

  @override
  State<FormQuadra> createState() => _FormQuadraState();
}

class _FormQuadraState extends State<FormQuadra> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoPorHoraController = TextEditingController();
  final TextEditingController _tipoDePisoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _capacidadeController = TextEditingController();
  bool _disponibilidade = true;
  bool _cobertura = false;

  Future<void> _salvarQuadra() async {
    if (_formKey.currentState!.validate()) {
      final quadra = DTOQuadra(
        id: null,
        nome: _nomeController.text,
        precoPorHora: double.tryParse(_precoPorHoraController.text) ?? 0.0,
        tipoDePiso: _tipoDePisoController.text,
        descricao: _descricaoController.text,
        capacidadeDeJogadores: int.tryParse(_capacidadeController.text) ?? 0,
        disponibilidade: _disponibilidade,
        cobertura: _cobertura,
      );

      try {
        final dao = DAOQuadra();
        await dao.salvar(quadra);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quadra cadastrada com sucesso!')),
        );

        _formKey.currentState!.reset();
        _nomeController.clear();
        _precoPorHoraController.clear();
        _tipoDePisoController.clear();
        _descricaoController.clear();
        _capacidadeController.clear();
        setState(() {
          _disponibilidade = true;
          _cobertura = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar quadra: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Voltar'),
        backgroundColor: const Color(0xFF5CE1E6),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cadastrar Quadra',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF025162),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: _nomeController,
                  decoration: _buildInputDecoration('Nome'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe o nome' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _precoPorHoraController,
                  decoration: _buildInputDecoration('Preço por Hora'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe o preço' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _tipoDePisoController,
                  decoration: _buildInputDecoration('Tipo de Piso'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Informe o tipo de piso'
                      : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descricaoController,
                  decoration: _buildInputDecoration('Descrição'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe a descrição' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _capacidadeController,
                  decoration: _buildInputDecoration('Capacidade de Jogadores'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Informe a capacidade de jogadores'
                      : null,
                ),
                const SizedBox(height: 16.0),
                SwitchListTile(
                  title: const Text('Disponibilidade'),
                  value: _disponibilidade,
                  onChanged: (value) {
                    setState(() {
                      _disponibilidade = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Cobertura'),
                  value: _cobertura,
                  onChanged: (value) {
                    setState(() {
                      _cobertura = value;
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _salvarQuadra,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5CE1E6),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Cadastrar Quadra',
                      style: TextStyle(
                        color: Color(0xFF025162),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListaQuadra(), // Página de lista de quadras
                      ),
                    );
                  },
                  child: const Text(
                    'Ver Lista de Quadras',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF025162),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF025162)),
      filled: true,
      fillColor: const Color(0xFF5CE1E6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
    );
  }
}
