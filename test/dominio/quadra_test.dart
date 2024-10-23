import 'package:flutter_test/flutter_test.dart';
import 'package:beach_rent/dominio/dto/dto_quadra.dart';
import 'package:beach_rent/dominio/interface/i_dao_quadra.dart';
import 'package:beach_rent/dominio/quadra.dart';


class DAOQuadra implements IDAOQuadra {
  @override
  DTOQuadra salvar(DTOQuadra dto) {
  return dto;
  }
}

    main() {
      var dto = DTOQuadra(
        id: 1,
        nome: 'Quadra Beach',
        precoPorHora: 50.00,
        tipoDePiso: 'Areia',
        descricao: 'Quadra média, recomendada para Beach Tennis',
        capacidadeDeJogadores: 12,
        disponibilidade: true,
        cobertura: false,
      );

      var dtoPrecoInvalido = DTOQuadra(
        id: 1,
        nome: 'Quadra Beach',
        precoPorHora: 0,
        tipoDePiso: 'Areia',
        descricao: 'Quadra média, recomendada para Beach Tennis',
        capacidadeDeJogadores: 12,
        disponibilidade: true,
        cobertura: false,
      );

      var dtoNomeInvalido = DTOQuadra(
        id: 1,
        nome: '',
        precoPorHora: 50.00,
        tipoDePiso: 'Areia',
        descricao: 'Quadra média, recomendada para Beach Tennis',
        capacidadeDeJogadores: 12,
        disponibilidade: true,
        cobertura: false,
      );

      var dtoTipoDePisoInvalido = DTOQuadra(
        id: 1,
        nome: 'Quadra Beach',
        precoPorHora: 50.00,
        tipoDePiso: '',
        descricao: 'Quadra média, recomendada para Beach Tennis',
        capacidadeDeJogadores: 12,
        disponibilidade: true,
        cobertura: false,
      );

      var dtoDescricaoInvalida = DTOQuadra(
        id: 1,
        nome: 'Quadra Beach',
        precoPorHora: 50.00,
        tipoDePiso: 'Areia',
        descricao: '',
        capacidadeDeJogadores: 12,
        disponibilidade: true,
        cobertura: false,
      );

      var dtoCapacidadeInvalida = DTOQuadra(
        id: 1,
        nome: 'Quadra Beach',
        precoPorHora: 50.00,
        tipoDePiso: 'Areia',
        descricao: 'Quadra média, recomendada para Beach Tennis',
        capacidadeDeJogadores: 13,
        disponibilidade: true,
        cobertura: false,
      );

      var dao = DAOQuadra();
      var quadra = Quadra(dto: dto, dao: dao);
      var quadraSemPreco = Quadra(dto: dtoPrecoInvalido, dao: dao);
      var quadraSemNome = Quadra(dto: dtoNomeInvalido, dao: dao);
      var quadraSemTipoDePiso = Quadra(dto: dtoTipoDePisoInvalido, dao: dao);
      var quadraSemDescricao = Quadra(dto: dtoDescricaoInvalida, dao: dao);
      var quadraCapacidadeInvalida = Quadra(dto: dtoCapacidadeInvalida, dao: dao);

      group('Testes de Quadra', () {
        test('Salvar quadra', () {
          expect(() => quadra.validarPreco(), returnsNormally);
        });

        test('Salvar quadra com preço inválido', () {
          expect(() => quadraSemPreco.validarPreco(), throwsException);
        });

        test('Salvar quadra com nome inválido', () {
          expect(() => quadraSemNome.validarNome(), throwsException);
        });

        test('Salvar quadra com tipo de piso inválido', () {
          expect(() => quadraSemTipoDePiso.validarTipoDePiso(), throwsException);
        });

        test('Salvar quadra com descrição inválida', () {
          expect(() => quadraSemDescricao.validarDescricao(), throwsException);
        });

        test('Salvar quadra com capacidade de jogadores inválida', () {
          expect(() => quadraCapacidadeInvalida.validarCapacidadeDeJogadores(), throwsException);
        });
      });
} 



