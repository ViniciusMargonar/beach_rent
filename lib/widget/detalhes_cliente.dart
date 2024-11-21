import 'package:flutter/material.dart';
import 'package:beach_rent/aplicacao/a_cliente.dart';
import 'package:beach_rent/dominio/dto/dto_cliente.dart';

class DetalhesCliente extends StatelessWidget {
  final String clienteId; // Agora recebe apenas o ID do cliente

  const DetalhesCliente({super.key, required this.clienteId});

  Future<DTOCliente?> _buscarDetalhesCliente(String id) async {
    try {
      final clientes = await ACliente.consultarClientes();
      // Lança uma exceção caso não encontre o cliente
      return clientes.firstWhere((cliente) => cliente.id == id);
    } catch (e) {
      print('Erro ao buscar detalhes do cliente: $e');
      return null; // Ou você pode retornar uma instância vazia de DTOCliente se preferir
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco
      appBar: AppBar(
        title: const Text('Voltar'),
        backgroundColor: const Color(0xFF5CE1E6), // Azul claro
      ),
      body: FutureBuilder<DTOCliente?>(
        future: _buscarDetalhesCliente(clienteId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Erro no FutureBuilder: ${snapshot.error}');
            return const Center(child: Text('Erro ao carregar detalhes.'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Cliente não encontrado.'));
          }

          final cliente = snapshot.data!;
          return Center( // Center para centralizar o card
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 350, // A largura do card foi aumentada
                child: Card(
                  color: const Color(0xFF5CE1E6), // Azul claro
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4, // Adiciona sombra para o card
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // Faz o card ocupar apenas o tamanho necessário
                      children: [
                        const Center(
                          child: Text(
                            'Detalhes do Cliente',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF025162), // Azul escuro
                            ),
                          ),
                        ),
                        const Text(
                          'Nome:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF025162), // Azul escuro
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cliente.nome,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF025162),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Email:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF025162), // Azul escuro
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cliente.email,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF025162),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Telefone:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF025162), // Azul escuro
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cliente.telefone,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF025162),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
