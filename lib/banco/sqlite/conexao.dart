import 'package:beach_rent/banco/script.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static late Database _db;
  static bool conexaoCriada = false;

  static Future<Database> abrir() async {
    if (!conexaoCriada) {
      var path = join(await getDatabasesPath(), 'banco.db');

      // Abre o banco e, se necessário, cria as tabelas
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          // Executa as queries de criação de tabelas
          for (var tabela in criarTabelas) {
            await db.execute(tabela);
          }

          // Executa as queries de inserção de registros
          for (var registro in inserirRegistros) {
            await db.execute(registro);
          }
        },
      );
      conexaoCriada = true;
    }

    return _db;
  }
}
