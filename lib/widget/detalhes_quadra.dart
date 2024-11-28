import 'package:flutter/material.dart';
import 'package:beach_rent/aplicacao/a_quadra.dart';
import 'package:beach_rent/dominio/dto/dto_quadra.dart';

class DetalhesQuadra extends StatelessWidget {
  final int quadraId; // Recebe o ID da quadra como int

  const DetalhesQuadra({super.key, required this.quadraId});

  // Altere o tipo do parâmetro para int
  Future<DTOQuadra?> _buscarDetalhesQuadra(int id) async {
    try {
      final quadras = await AQuadra.consultarQuadras();
      // Certifique-se de que a comparação seja feita entre dois int
      return quadras.firstWhere((quadra) => quadra.id == id);
    } catch (e) {
      print('Erro ao buscar detalhes da quadra: $e');
      return null;
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
      body: FutureBuilder<DTOQuadra?>(
        future: _buscarDetalhesQuadra(quadraId), // Passa o int diretamente
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Erro no FutureBuilder: ${snapshot.error}');
            return const Center(child: Text('Erro ao carregar detalhes.'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Quadra não encontrada.'));
          }

          final quadra = snapshot.data!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 350, // Largura do card
                child: Card(
                  color: const Color(0xFF5CE1E6), // Azul claro
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4, // Sombra no card
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                          child: Text(
                            'Detalhes da Quadra',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF025162), // Azul escuro
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow('Nome:', quadra.nome),
                        _buildDetailRow('Preço por Hora:', 'R\$ ${quadra.precoPorHora.toStringAsFixed(2)}'),
                        _buildDetailRow('Tipo de Piso:', quadra.tipoDePiso),
                        _buildDetailRow('Descrição:', quadra.descricao),
                        _buildDetailRow('Capacidade de Jogadores:', '${quadra.capacidadeDeJogadores} jogadores'),
                        _buildDetailRow('Disponibilidade:', quadra.disponibilidade ? 'Disponível' : 'Indisponível'),
                        _buildDetailRow('Cobertura:', quadra.cobertura ? 'Coberta' : 'Descoberta'),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF025162),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF025162),
            ),
          ),
        ],
      ),
    );
  }
}
