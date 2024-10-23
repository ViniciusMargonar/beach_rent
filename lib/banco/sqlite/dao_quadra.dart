import 'package:beach_rent/dominio/dto/dto_quadra.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DAOQuadra {
  static final DAOQuadra _instance = DAOQuadra._internal();
  factory DAOQuadra() => _instance;
  DAOQuadra._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'quadra_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE quadra(id INTEGER PRIMARY KEY, nome TEXT, precoPorHora REAL, tipoDePiso TEXT, descricao TEXT, capacidadeDeJogadores INTEGER, disponibilidade TEXT, cobertura TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertQuadra(DTOQuadra quadra) async {
    final db = await database;
    await db.insert(
      'quadra',
      quadra.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DTOQuadra>> quadras() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('quadra');
    return List.generate(maps.length, (i) {
      return DTOQuadra(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        precoPorHora: maps[i]['precoPorHora'],
        tipoDePiso: maps[i]['tipoDePiso'],
        descricao: maps[i]['descricao'],
        capacidadeDeJogadores: maps[i]['capacidadeDeJogadores'],
        disponibilidade: maps[i]['disponibilidade'],
        cobertura: maps[i]['cobertura'],
      );
    });
  }

  Future<void> updateQuadra(DTOQuadra quadra) async {
    final db = await database;
    await db.update(
      'quadra',
      quadra.toMap(),
      where: 'id = ?',
      whereArgs: [quadra.id],
    );
  }

  Future<void> deleteQuadra(int id) async {
    final db = await database;
    await db.delete(
      'quadra',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

extension on DTOQuadra {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'precoPorHora': precoPorHora,
      'tipoDePiso': tipoDePiso,
      'descricao': descricao,
      'capacidadeDeJogadores': capacidadeDeJogadores,
      'disponibilidade': disponibilidade,
      'cobertura': cobertura,
    };
  }
}