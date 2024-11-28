const criarTabelas = [
  '''
  CREATE TABLE cliente (
    id INTEGER NOT NULL PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL,
    telefone CHAR(14) NOT NULL,
    senha VARCHAR(200) NOT NULL
  );
  ''',
  '''
  CREATE TABLE quadra (
    id INTEGER NOT NULL PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    precoPorHora REAL NOT NULL,
    tipoDePiso VARCHAR(50) NOT NULL,
    descricao TEXT,
    capacidadeDeJogadores INTEGER NOT NULL,
    disponibilidade BOOLEAN NOT NULL,
    cobertura BOOLEAN NOT NULL
  );
  '''
];

const inserirRegistros = [
  'INSERT INTO cliente (nome, email, telefone, senha) VALUES ("RONALDO", "ronaldinhog@gmail.com", "44912364588", "123456")',
  'INSERT INTO quadra (nome, precoPorHora, tipoDePiso, descricao, capacidadeDeJogadores, disponibilidade, cobertura) '
  'VALUES ("Quadra de Areia", 150.0, "Areia", "Quadra ideal para vôlei e futevôlei", 10, 1, 0)'
];
