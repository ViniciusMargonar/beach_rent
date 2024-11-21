import 'package:beach_rent/aplicacao/a_cliente.dart';
import 'package:flutter/material.dart';
import 'detalhes_cliente.dart';
import 'package:beach_rent/dominio/dto/dto_cliente.dart';

class ListaCliente extends StatelessWidget {
  const ListaCliente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
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
            itemCount: lista.length,
            itemBuilder: (context, index) {
              var cliente = lista[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(cliente.nome),
                subtitle: Text(cliente.email),
                onTap: () {
                  // Navega para a página de detalhes do cliente
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesCliente(cliente: cliente),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
