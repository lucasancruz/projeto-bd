import 'package:app/models/manga.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';

class MangaHeader extends StatelessWidget {
  const MangaHeader({
    Key? key,
    required this.manga,
  }) : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: Colors.grey, fontSize: 14);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: AspectRatio(
            aspectRatio: 0.75,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                manga.imagem,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: kDefaultMargin),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              manga.titulo,
              style: style.copyWith(color: Colors.white, fontSize: 16),
            ),
            if (manga.autores.isNotEmpty)
              Text(
                manga.autores.join(', '),
                style: style,
              ),
            Text(
              manga.editora,
              style: style,
            ),
            Text(
              manga.dataFinalizacao != null
                  ? 'Publicação Finalizada'
                  : 'Publicação em Andamento',
              style: style,
            ),
          ],
        ),
      ],
    );
  }
}
