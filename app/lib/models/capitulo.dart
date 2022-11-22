class Capitulo {
  final String titulo;
  final int numero;
  final String url;
  final DateTime dataPublicacao;

  Capitulo(this.titulo, this.numero, this.url, this.dataPublicacao);

  Capitulo.fromJson(Map<String, dynamic> json)
      : titulo = json['titulo'],
        numero = json['numero'],
        url = json['url'],
        dataPublicacao = DateTime.parse(json['data_publicacao']);
}
