import 'package:beach_rent/banco/sqlite/conexao.dart';
import 'package:beach_rent/dominio/dto/dto_cliente.dart';

class ACliente {
  // Método para consultar os clientes no banco e retornar uma lista de DTOCliente
  static Future<List<DTOCliente>> consultarClientes() async {
    try {
      final db = await Conexao.abrir(); // Abre a conexão com o banco
      final result = await db.query('cliente'); // Consulta a tabela cliente

      // Converte o resultado para uma lista de DTOCliente
      return result.map((json) => DTOCliente(
            id: json['id'].toString(),
            nome: json['nome'].toString(),
            email: json['email'].toString(),
            telefone: json['telefone'].toString(),
            senha: json['senha'].toString(),
          )).toList();
    } catch (e) {
      print('Erro ao consultar clientes na classe ACliente: $e');
      return [];
    }
  }
}
