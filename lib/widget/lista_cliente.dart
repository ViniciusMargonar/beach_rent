import 'package:beach_rent/aplicacao/a_cliente.dart';
import 'package:flutter/material.dart';
import 'detalhes_cliente.dart';
import 'package:beach_rent/dominio/dto/dto_cliente.dart';

class ListaCliente extends StatelessWidget {
  const ListaCliente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
        backgroundColor: const Color(0xFF5CE1E6), // Azul claro
      ),
      body: FutureBuilder<List<DTOCliente>>(
        future: ACliente.consultarClientes(), // Usa o método da classe ACliente
        builder:
            (BuildContext context, AsyncSnapshot<List<DTOCliente>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Erro no FutureBuilder: ${snapshot.error}');
            return const Center(child: Text('Erro ao carregar dados.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum cliente encontrado.'));
          }

          var lista = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: lista.length,
            itemBuilder: (context, index) {
              var cliente = lista[index];
              return Card(
                color: const Color(0xFF5CE1E6), // Azul claro
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: const Icon(
                    Icons.person,
                    color: Color(0xFF025162), // Azul escuro
                  ),
                  title: Text(
                    cliente.nome,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF025162), // Azul escuro
                    ),
                  ),
                  subtitle: Text(
                    cliente.email,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF025162), // Azul escuro
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF025162), // Azul escuro
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesCliente(clienteId: cliente.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
