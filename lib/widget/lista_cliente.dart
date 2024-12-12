import 'package:flutter/material.dart';
import 'package:beach_rent/aplicacao/a_cliente.dart';
import 'package:beach_rent/banco/sqlite/dao_cliente.dart';
import 'package:beach_rent/dominio/dto/dto_cliente.dart';
import 'detalhes_cliente.dart';

class ListaCliente extends StatefulWidget {
  const ListaCliente({super.key});

  @override
  _ListaClienteState createState() => _ListaClienteState();
}

class _ListaClienteState extends State<ListaCliente> {
  late Future<List<DTOCliente>> _clientesFuture;

  @override
  void initState() {
    super.initState();
    _clientesFuture = ACliente.consultarClientes();
  }

  // Função para exibir o formulário de atualização
  void _atualizarCliente(DTOCliente cliente) {
    final TextEditingController nomeController = TextEditingController(text: cliente.nome);
    final TextEditingController emailController = TextEditingController(text: cliente.email);
    final TextEditingController telefoneController = TextEditingController(text: cliente.telefone);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atualizar Cliente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Atualizar cliente
                cliente.nome = nomeController.text;
                cliente.email = emailController.text;
                cliente.telefone = telefoneController.text;

                try {
                  DAOCliente daoCliente = DAOCliente();
                  await daoCliente.atualizar(cliente);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cliente "${cliente.nome}" atualizado com sucesso!'),
                    ),
                  );

                  // Atualizar a lista
                  setState(() {});
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao atualizar cliente: $e'),
                    ),
                  );
                }
              },
              child: const Text('Atualizar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
        backgroundColor: const Color(0xFF5CE1E6), // Azul claro
      ),
      body: FutureBuilder<List<DTOCliente>>(
        future: _clientesFuture,
        builder: (BuildContext context, AsyncSnapshot<List<DTOCliente>> snapshot) {
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
                    'Telefone: ${cliente.telefone}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF025162), // Azul escuro
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min, // Limita o tamanho horizontal
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color(0xFF025162), // Azul escuro
                        ),
                        onPressed: () async {
                          // Confirmação de exclusão
                          bool? confirmar = await showDialog<bool>( 
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Confirmar Exclusão'),
                                content: Text('Deseja excluir o cliente "${cliente.nome}"?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('Excluir'),
                                  ),
                                ],
                              );
                            },
                          );

                          // Executa exclusão se confirmado
                          if (confirmar == true) {
                            try {
                              // Usando o DAOCliente para deletar o cliente
                              DAOCliente daoCliente = DAOCliente();
                              await daoCliente.deletar(cliente.id);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Cliente "${cliente.nome}" excluído com sucesso!'),
                                ),
                              );

                              // Atualiza a lista removendo o cliente excluído
                              setState(() {
                                lista.removeAt(index);
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erro ao excluir cliente: $e'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Color(0xFF025162), // Azul escuro
                        ),
                        onPressed: () {
                          _atualizarCliente(cliente);
                        },
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF025162), // Azul escuro
                      ),
                    ],
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
