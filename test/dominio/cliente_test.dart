import 'package:flutter_test/flutter_test.dart';
import 'package:beach_rent/dominio/dto/dto_cliente.dart';
import 'package:beach_rent/dominio/interface/i_dao_cliente.dart';
import 'package:beach_rent/dominio/cliente.dart';

class MockDAOCliente implements IDAOCliente {
  @override
  Future<DTOCliente> salvar(DTOCliente dto) async {
    // Simulação de salvamento
    return dto;
  }
}

void main() {
  group('Testes de validação de e-mail', () {
      late Cliente cliente;
      late DTOCliente dto;
  
      setUp(() {
        dto = DTOCliente(id: 1, nome: 'João', email: 'email@valido.com', telefone: '12345678', senha: 'senha123');
        cliente = Cliente(dto: dto, dao: MockDAOCliente());
      });
  
      test('Validar e-mail correto', () {
        expect(() => cliente.validarEmail('email@valido.com'), returnsNormally);
      });
  
      test('Validar e-mail inválido', () {
        expect(() => cliente.validarEmail('email_invalido.com'), throwsException);
      });
  
      test('Validar e-mail sem domínio', () {
        expect(() => cliente.validarEmail('email@invalido'), throwsException);
      });
  
      test('Validar e-mail sem "@"', () {
        expect(() => cliente.validarEmail('emailinvalido.com'), throwsException);
      });
    });
  
    group('Testes do método salvar', () {
      late Cliente cliente;
      late DTOCliente dto;
  
      setUp(() {
        dto = DTOCliente(id: 1, nome: 'João', email: 'email@valido.com', telefone: '12345678', senha: 'senha123');
        cliente = Cliente(dto: dto, dao: MockDAOCliente());
      });
  
      test('Salvar cliente com e-mail válido', () async {
        DTOCliente novoDto = DTOCliente(id: 2, nome: 'Maria', email: 'maria@valido.com', telefone: '87654321', senha: 'senha321');
        DTOCliente resultado = await cliente.salvar(novoDto);
        expect(resultado.email, 'maria@valido.com');
      });
  
      test('Salvar cliente com e-mail inválido', () async {
        DTOCliente novoDto = DTOCliente(id: 2, nome: 'Maria', email: 'maria_invalido.com', telefone: '87654321', senha: 'senha321');
        expect(() => cliente.salvar(novoDto), throwsException);
      });
    });
    group('Testes de validação telefone', () {
      
    });

    
}
