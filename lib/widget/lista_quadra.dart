import 'package:beach_rent/aplicacao/a_quadra.dart';
import 'package:flutter/material.dart';
import 'detalhes_quadra.dart';
import 'package:beach_rent/dominio/dto/dto_quadra.dart';

class ListaQuadra extends StatelessWidget {
  const ListaQuadra({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco
      appBar: AppBar(
        title: const Text('Lista de Quadras'),
        backgroundColor: const Color(0xFF5CE1E6), // Azul claro
      ),
      body: FutureBuilder<List<DTOQuadra>>(
        future: AQuadra.consultarQuadras(), // Usa o método da classe AQuadra
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
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF025162), // Azul escuro
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
