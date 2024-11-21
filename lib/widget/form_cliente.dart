import 'package:beach_rent/widget/lista_cliente.dart';
import 'package:flutter/material.dart';
import 'package:beach_rent/banco/sqlite/conexao.dart';
import 'package:beach_rent/dominio/dto/dto_cliente.dart';
import 'package:beach_rent/banco/sqlite/dao_cliente.dart'; // Certifique-se de importar a classe DAOCliente corretamente

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
      // Cria o DTOCliente com os dados do formulário
      final cliente = DTOCliente(
        id: null, // O ID será gerado automaticamente no banco
        nome: _nomeController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
        senha: _senhaController.text,
      );

      try {
        // Salva o cliente no banco de dados
        final dao = DAOCliente();
        await dao.salvar(cliente);

        // Exibe mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente cadastrado com sucesso!')),
        );

        // Limpa os campos após o cadastro
        _formKey.currentState!.reset();
        _nomeController.clear();
        _emailController.clear();
        _telefoneController.clear();
        _senhaController.clear();
      } catch (e) {
        // Exibe mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar cliente: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o email' : null,
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe o telefone'
                    : null,
              ),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a senha' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarCliente,
                child: const Text('Cadastrar Cliente'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ListaCliente()),
                  );
                },
                child: const Text('Voltar para a Lista de Clientes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
