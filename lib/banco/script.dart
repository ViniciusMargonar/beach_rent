const criarTabelas = [
  ''' 
  CREATE TABLE cliente (
    id INTEGER NOT NULL PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL,
    telefone CHAR(14) NOT NULL,
    senha VARCHAR(200) NOT NULL
  );
  '''
];

const inserirRegistros = [
  'INSERT INTO cliente (nome, email, telefone, senha) VALUES ("RONALDO","ronaldinhog@gmail.com","44912364588","123456")',
];
