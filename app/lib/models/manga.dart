import 'package:app/models/capitulo.dart';

class Manga {
  final int id;
  final String titulo;
  final String sinopse;
  final String imagem;
  final DateTime? dataCriacao;
  final DateTime? dataFinalizacao;
  final String editora;
  final List<String> generos;
  final List<String> autores;
  final List<Capitulo> capitulos;

  Manga({
    required this.id,
    required this.titulo,
    required this.sinopse,
    required this.imagem,
    this.dataCriacao,
    this.dataFinalizacao,
    required this.editora,
    required this.generos,
    required this.autores,
    required this.capitulos,
  });

  Manga.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        titulo = json['titulo'],
        sinopse = json['sinopse'],
        imagem = json['imagem'],
        dataCriacao = json['dataCriacao'],
        dataFinalizacao = json['dataFinalizacao'],
        editora = json['editora']?['nome'],
        generos = json['generos'] ?? [],
        autores = json['autores'] ?? [],
        capitulos = json['capitulos']?.map<Capitulo>((capitulo) => Capitulo.fromJson(capitulo)).toList() ?? [];
}
