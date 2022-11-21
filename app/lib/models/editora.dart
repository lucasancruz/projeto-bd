class Editora {
  final int id;
  final String nome;

  Editora({
    required this.id,
    required this.nome,
  });

  Editora.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'];
}
