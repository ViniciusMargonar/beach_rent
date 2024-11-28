import 'package:beach_rent/banco/sqlite/conexao.dart';
import 'package:beach_rent/dominio/dto/dto_cliente.dart';
import 'package:beach_rent/dominio/interface/i_dao_cliente.dart';
import 'package:sqflite/sqflite.dart';

class DAOCliente implements IDAOCliente {
  late Database _db;

  @override
  Future<DTOCliente> salvar(DTOCliente dto) async {
    _db = await Conexao.abrir();
    int id = await _db.rawInsert(
      'INSERT INTO cliente (nome, email, telefone, senha) VALUES (?,?,?,?)', 
      [dto.nome, dto.email, dto.telefone, dto.senha]
    );
    dto.id = id;
    return dto;
  }

  @override
  Future<DTOCliente> deletar(DTOCliente dto) async {  // Usando o DTOCliente
    _db = await Conexao.abrir();
    await _db.rawDelete('DELETE FROM cliente WHERE id = ?', [dto.id]);  // Acessando o id do DTOCliente
    return dto;
  }
}
