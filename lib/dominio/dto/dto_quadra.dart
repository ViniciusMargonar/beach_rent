class DTOQuadra {
  late dynamic id;
  late String nome;
  late double precoPorHora;
  late String tipoDePiso; // Areia, grama, piso, etc.
  late String descricao;
  late int capacidadeDeJogadores;
  late bool disponibilidade;
  late bool cobertura;


  DTOQuadra({
    required this.id,
    required this.nome,
    required this.precoPorHora,
    required this.tipoDePiso,
    required this.descricao,
    required this.capacidadeDeJogadores,
    required this.disponibilidade,
    required this.cobertura,
  });
}
  