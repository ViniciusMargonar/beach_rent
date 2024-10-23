import 'package:beach_rent/dominio/dto/dto_cliente.dart';
import 'package:beach_rent/dominio/interface/i_dao_cliente.dart';

class Cliente{
  late dynamic id;
  late String nome;
  late String email;
  late String telefone;
  late String senha;

  late IDAOCliente dao;
  late DTOCliente dto;

  Cliente({required this.dto, required this.dao}){
    id = dto.id;
    nome = dto.nome;
    email = dto.email;
    telefone = dto.telefone;
    senha = dto.senha;
  }

  Future<DTOCliente> salvar(DTOCliente dto){
    validarEmail(dto.email);
    return dao.salvar(dto);
  }

  void validarEmail(String email) {
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(email)) {
      throw Exception('O e-mail fornecido não é válido: $email');
    }
  }

  void validarTelefone(String telefone) {
    const telefonePattern = r'^\(\d{2}\) \d{5}-\d{4}$';
    final regExp = RegExp(telefonePattern);

    if (!regExp.hasMatch(telefone)) {
      throw Exception('O telefone fornecido não é válido: $telefone');
    }
  }
}