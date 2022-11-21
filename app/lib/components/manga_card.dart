import 'package:app/models/manga.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';

class MangaCard extends StatelessWidget {
  const MangaCard({super.key, required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 140/170,
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding / 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).primaryColorDark,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                manga.imagem,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: kDefaultMargin / 2),
        Text(
          manga.titulo,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
