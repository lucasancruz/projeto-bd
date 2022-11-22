import 'package:app/models/manga.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CapitulosList extends StatelessWidget {
  const CapitulosList({
    Key? key,
    required this.manga,
  }) : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: manga.capitulos.length,
      itemBuilder: (context, index) {
        final capitulo = manga.capitulos[index];

        return InkWell(
          onTap: () {},
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "${capitulo.numero} - ${capitulo.titulo}",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.grey),
            ),
            subtitle: Text(
              DateFormat("dd/MM/yyyy").format(capitulo.dataPublicacao),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.grey),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
        height: 2,
      ),
    );
  }
}
