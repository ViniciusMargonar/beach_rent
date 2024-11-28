import 'package:beach_rent/banco/sqlite/conexao.dart';
import 'package:beach_rent/dominio/dto/dto_quadra.dart';

class AQuadra {
  // Método para consultar as quadras no banco e retornar uma lista de DTOQuadra
  static Future<List<DTOQuadra>> consultarQuadras() async {
    try {
      final db = await Conexao.abrir(); // Abre a conexão com o banco
      final result = await db.query('quadra'); // Consulta a tabela quadra

      // Converte o resultado para uma lista de DTOQuadra
      return result.map((json) => DTOQuadra(
            id: json['id'],
            nome: json['nome'].toString(),
            precoPorHora: double.parse(json['precoPorHora'].toString()),
            tipoDePiso: json['tipoDePiso'].toString(),
            descricao: json['descricao'].toString(),
            capacidadeDeJogadores: int.parse(json['capacidadeDeJogadores'].toString()),
            disponibilidade: json['disponibilidade'] == 1,
            cobertura: json['cobertura'] == 1,
          )).toList();
    } catch (e) {
      print('Erro ao consultar quadras na classe AQuadra: $e');
      return [];
    }
  }
}
