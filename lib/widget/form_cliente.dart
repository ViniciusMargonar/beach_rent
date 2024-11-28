import 'package:beach_rent/widget/lista_cliente.dart';
import 'package:flutter/material.dart';
import 'package:beach_rent/banco/sqlite/dao_cliente.dart';
import 'package:beach_rent/dominio/dto/dto_cliente.dart';

class FormCliente extends StatefulWidget {
  const FormCliente({super.key});

  @override
  State<FormCliente> createState() => _FormClienteState();
}

class _FormClienteState extends State<FormCliente> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  Future<void> _salvarCliente() async {
    if (_formKey.currentState!.validate()) {
      final cliente = DTOCliente(
        id: null,
        nome: _nomeController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
        senha: _senhaController.text,
      );

      try {
        final dao = DAOCliente();
        await dao.salvar(cliente);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente cadastrado com sucesso!')),
        );

        _formKey.currentState!.reset();
        _nomeController.clear();
        _emailController.clear();
        _telefoneController.clear();
        _senhaController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar cliente: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco
      appBar: AppBar(
        title: const Text('Voltar'),
        backgroundColor: const Color(0xFF5CE1E6), // Azul escuro
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
                  'Cadastrar Cliente',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF025162),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0), // Espaçamento entre o título e os inputs
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: const TextStyle(color: Color(0xFF025162)),
                    filled: true,
                    fillColor: const Color(0xFF5CE1E6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe o nome' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Color(0xFF025162)),
                    filled: true,
                    fillColor: const Color(0xFF5CE1E6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe o email' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _telefoneController,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    labelStyle: const TextStyle(color: Color(0xFF025162)),
                    filled: true,
                    fillColor: const Color(0xFF5CE1E6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe o telefone' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: const TextStyle(color: Color(0xFF025162)),
                    filled: true,
                    fillColor: const Color(0xFF5CE1E6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe a senha' : null,
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _salvarCliente,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5CE1E6),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Cadastrar Cliente',
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListaCliente()),
                    );
                  },
                  child: const Text(
                    'Ver Lista de Clientes',
                    style: TextStyle(
                      color: Color(0xFF025162),
                      fontSize: 14.0,
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
}
