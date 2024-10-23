import 'package:beach_rent/dominio/dto/dto_quadra.dart';
import 'package:beach_rent/dominio/interface/i_dao_quadra.dart';

class Quadra {
  late dynamic id;
  late String nome;
  late double precoPorHora;
  late String tipoDePiso; // Areia, grama, piso, etc.
  late String descricao;
  late int capacidadeDeJogadores;
  late bool disponibilidade;
  late bool cobertura;

  late IDAOQuadra dao;
  late DTOQuadra dto;

  Quadra({required this.dto, required this.dao}) {
    id = dto.id;
    nome = dto.nome;
    precoPorHora = dto.precoPorHora;
    tipoDePiso = dto.tipoDePiso;
    descricao = dto.descricao;
    capacidadeDeJogadores = dto.capacidadeDeJogadores;
    disponibilidade = dto.disponibilidade;
    cobertura = dto.cobertura;
  }

  void validarNome() {
    if (dto.nome.isEmpty) {
      throw Exception("Nome da quadra não pode ser vazio");
    }
    if (dto.nome.length < 3) {
      throw Exception("Nome da quadra deve ter pelo menos 3 caracteres");
    }
  }

  void validarPreco() {
    if (dto.precoPorHora <= 0) {
      throw Exception("Preço por hora deve ser maior que zero");
    }
    if (dto.precoPorHora > 300) {
      throw Exception("Preço por hora não pode ser maior que 1000");
    }
  }

  void validarTipoDePiso() {
    if (dto.tipoDePiso.isEmpty) {
      throw Exception("Tipo de piso não pode ser vazio");
    }
    const validTiposDePiso = ['Areia', 'Grama', 'Piso'];
    if (!validTiposDePiso.contains(dto.tipoDePiso)) {
      throw Exception("Tipo de piso inválido");
    }
  }

  void validarDescricao() {
    if (dto.descricao.isEmpty) {
      throw Exception("Obrigatório conter uma descrição sobre a quadra!");
    }
    if (dto.descricao.length < 10) {
      throw Exception("Descrição deve ter pelo menos 10 caracteres");
    }
  }

  void validarCapacidadeDeJogadores() {
    if (dto.capacidadeDeJogadores <= 0) {
      throw Exception("Capacidade de jogadores deve ser maior que zero");
    }
    if (dto.capacidadeDeJogadores > 12) {
      throw Exception("Capacidade de jogadores não pode ser maior que 12");
    }
  }
}
