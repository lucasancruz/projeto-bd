import 'package:app/models/capitulo.dart';

class Manga {
  final int id;
  final String titulo;
  final String sinopse;
  final String imagem;
  final DateTime? dataCriacao;
  final DateTime? dataFinalizacao;
  final String editora;
  final int editoraID;
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
    required this.editoraID,
    required this.generos,
    required this.autores,
    required this.capitulos,
  });

  Manga.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        titulo = json['titulo'],
        sinopse = json['sinopse'],
        imagem = json['imagem'],
        dataCriacao = DateTime.tryParse(json['data_criacao'].toString()),
        dataFinalizacao = DateTime.tryParse(json['data_finalizacao'].toString()),
        editora = json['editora']?['nome'] ?? '',
        editoraID = json['editora_id'],
        generos = json['generos']?.cast<String>() ?? [],
        autores = json['autores']?.cast<String>() ?? [],
        capitulos = json['capitulos']
                ?.map<Capitulo>((capitulo) => Capitulo.fromJson(capitulo))
                .toList() ??
            [];
}
