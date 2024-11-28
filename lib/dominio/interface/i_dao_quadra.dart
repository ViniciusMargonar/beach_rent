import 'package:beach_rent/dominio/dto/dto_quadra.dart';

abstract class IDAOQuadra {
  Future<DTOQuadra> salvar(DTOQuadra dto);
  Future<int> atualizar(DTOQuadra dto);
  Future<int> deletar(int id);
  Future<DTOQuadra?> buscarPorId(int id);
  Future<List<DTOQuadra>> listarTodos();
}
