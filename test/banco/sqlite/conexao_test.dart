import 'package:flutter_test/flutter_test.dart';
import 'package:beach_rent/banco/sqlite/conexao.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Inicializa o sqflite para funcionar em plataformas de teste (Windows, Linux)
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  TestWidgetsFlutterBinding.ensureInitialized();

  group('Conexao', () {
    test('Database should be opened successfully', () async {
      var db = await Conexao.abrir();
      expect(db, isA<Database>());
    });

    test('Database should be a singleton', () async {
      var db1 = await Conexao.abrir();
      var db2 = await Conexao.abrir();
      expect(db1, db2);
    });

    test('Database should create tables and insert records', () async {
      var db = await Conexao.abrir();
      var tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
      expect(tables.isNotEmpty, true); // Verifica se as tabelas foram criadas

      var records = await db.query('cliente'); // Substitua 'your_table_name' pelo nome real da tabela
      expect(records.isNotEmpty, true); // Verifica se há registros na tabela
    });
  });
}
