import 'package:beach_rent/aplicacao/a_quadra.dart';
import 'package:beach_rent/banco/sqlite/dao_quadra.dart';
import 'package:beach_rent/dominio/dto/dto_quadra.dart';
import 'package:flutter/material.dart';
import 'detalhes_quadra.dart';

class ListaQuadra extends StatefulWidget {
  const ListaQuadra({super.key});

  @override
  _ListaQuadraState createState() => _ListaQuadraState();
}

class _ListaQuadraState extends State<ListaQuadra> {
  late Future<List<DTOQuadra>> _quadrasFuture;

  @override
  void initState() {
    super.initState();
    _quadrasFuture = AQuadra.consultarQuadras();
  }

  // Função para exibir o formulário de atualização
  void _atualizarQuadra(DTOQuadra quadra) {
    final TextEditingController nomeController = TextEditingController(text: quadra.nome);
    final TextEditingController precoController = TextEditingController(text: quadra.precoPorHora.toString());
    final TextEditingController tipoDePisoController = TextEditingController(text: quadra.tipoDePiso);
    final TextEditingController descricaoController = TextEditingController(text: quadra.descricao);
    final TextEditingController capacidadeController = TextEditingController(text: quadra.capacidadeDeJogadores.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atualizar Quadra'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: precoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Preço por Hora'),
              ),
              TextField(
                controller: tipoDePisoController,
                decoration: const InputDecoration(labelText: 'Tipo de Piso'),
              ),
              TextField(
                controller: descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              TextField(
                controller: capacidadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Capacidade de Jogadores'),
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
                // Atualizar quadra
                quadra.nome = nomeController.text;
                quadra.precoPorHora = double.tryParse(precoController.text) ?? quadra.precoPorHora;
                quadra.tipoDePiso = tipoDePisoController.text;
                quadra.descricao = descricaoController.text;
                quadra.capacidadeDeJogadores = int.tryParse(capacidadeController.text) ?? quadra.capacidadeDeJogadores;

                try {
                  DAOQuadra daoQuadra = DAOQuadra();
                  await daoQuadra.atualizar(quadra);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Quadra "${quadra.nome}" atualizada com sucesso!'),
                    ),
                  );

                  // Atualizar a lista
                  setState(() {});
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao atualizar quadra: $e'),
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
        title: const Text('Lista de Quadras'),
        backgroundColor: const Color(0xFF5CE1E6), // Azul claro
      ),
      body: FutureBuilder<List<DTOQuadra>>(
        future: _quadrasFuture,
        builder: (BuildContext context, AsyncSnapshot<List<DTOQuadra>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Erro no FutureBuilder: ${snapshot.error}');
            return const Center(child: Text('Erro ao carregar dados.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma quadra encontrada.'));
          }

          var lista = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: lista.length,
            itemBuilder: (context, index) {
              var quadra = lista[index];
              return Card(
                color: const Color(0xFF5CE1E6), // Azul claro
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: const Icon(
                    Icons.sports_volleyball,
                    color: Color(0xFF025162), // Azul escuro
                  ),
                  title: Text(
                    quadra.nome,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF025162), // Azul escuro
                    ),
                  ),
                  subtitle: Text(
                    'Capacidade: ${quadra.capacidadeDeJogadores} jogadores',
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
                                content: Text('Deseja excluir a quadra "${quadra.nome}"?'),
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
                              // Usando o DAOQuadra para deletar a quadra
                              DAOQuadra daoQuadra = DAOQuadra();
                              await daoQuadra.deletar(quadra.id);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Quadra "${quadra.nome}" excluída com sucesso!'),
                                ),
                              );

                              // Atualiza a lista removendo a quadra excluída
                              setState(() {
                                lista.removeAt(index);
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erro ao excluir quadra: $e'),
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
                          _atualizarQuadra(quadra);
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
                        builder: (context) => DetalhesQuadra(quadraId: quadra.id),
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
