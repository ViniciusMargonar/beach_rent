import 'package:beach_rent/banco/sqlite/conexao.dart';
import 'package:beach_rent/dominio/dto/dto_quadra.dart';
import 'package:beach_rent/dominio/interface/i_dao_quadra.dart';
import 'package:sqflite/sqflite.dart';

class DAOQuadra implements IDAOQuadra {
  late Database _db;

  @override
  Future<DTOQuadra> salvar(DTOQuadra dto) async {
    _db = await Conexao.abrir();
    int id = await _db.rawInsert(
      'INSERT INTO quadra (nome, precoPorHora, tipoDePiso, descricao, capacidadeDeJogadores, disponibilidade, cobertura) VALUES (?, ?, ?, ?, ?, ?, ?)', 
      [
        dto.nome,
        dto.precoPorHora,
        dto.tipoDePiso,
        dto.descricao,
        dto.capacidadeDeJogadores,
        dto.disponibilidade ? 1 : 0,
        dto.cobertura ? 1 : 0
      ]
    );
    dto.id = id;
    return dto;
  }

  @override
  Future<int> atualizar(DTOQuadra dto) async {
    _db = await Conexao.abrir();
    return await _db.rawUpdate(
      'UPDATE quadra SET nome = ?, precoPorHora = ?, tipoDePiso = ?, descricao = ?, capacidadeDeJogadores = ?, disponibilidade = ?, cobertura = ? WHERE id = ?',
      [
        dto.nome,
        dto.precoPorHora,
        dto.tipoDePiso,
        dto.descricao,
        dto.capacidadeDeJogadores,
        dto.disponibilidade ? 1 : 0,
        dto.cobertura ? 1 : 0,
        dto.id
      ]
    );
  }

  @override
  Future<int> deletar(int id) async {
    _db = await Conexao.abrir();
    return await _db.rawDelete('DELETE FROM quadra WHERE id = ?', [id]);
  }

  @override
  Future<DTOQuadra?> buscarPorId(int id) async {
    _db = await Conexao.abrir();
    List<Map<String, dynamic>> result = await _db.rawQuery('SELECT * FROM quadra WHERE id = ?', [id]);
    if (result.isNotEmpty) {
      return DTOQuadra(
        id: result[0]['id'],
        nome: result[0]['nome'],
        precoPorHora: result[0]['precoPorHora'],
        tipoDePiso: result[0]['tipoDePiso'],
        descricao: result[0]['descricao'],
        capacidadeDeJogadores: result[0]['capacidadeDeJogadores'],
        disponibilidade: result[0]['disponibilidade'] == 1,
        cobertura: result[0]['cobertura'] == 1,
      );
    }
    return null;
  }

  @override
  Future<List<DTOQuadra>> listarTodos() async {
    _db = await Conexao.abrir();
    List<Map<String, dynamic>> result = await _db.rawQuery('SELECT * FROM quadra');
    return result.map((map) => DTOQuadra(
      id: map['id'],
      nome: map['nome'],
      precoPorHora: map['precoPorHora'],
      tipoDePiso: map['tipoDePiso'],
      descricao: map['descricao'],
      capacidadeDeJogadores: map['capacidadeDeJogadores'],
      disponibilidade: map['disponibilidade'] == 1,
      cobertura: map['cobertura'] == 1,
    )).toList();
  }
  
}
