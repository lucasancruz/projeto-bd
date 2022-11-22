import 'package:app/components/capitulos_list.dart';
import 'package:app/components/manga_header.dart';
import 'package:app/models/manga.dart';
import 'package:app/pages/cadastrar_capitulo_page.dart';
import 'package:app/pages/cadastrar_manga_page.dart';
import 'package:app/repositories/manga_repository.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';

class MangaDetailPage extends StatefulWidget {
  const MangaDetailPage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<MangaDetailPage> createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  @override
  Widget build(BuildContext context) {
    final mangaRepo = MangaRepository();

    return FutureBuilder(
      future: mangaRepo.findById(widget.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final Manga manga = snapshot.data as Manga;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Detalhes",
              style: TextStyle(fontSize: 16),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MangaHeader(manga: manga),
                const SizedBox(height: kDefaultMargin),
                Text(
                  manga.sinopse,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(height: kDefaultMargin * 2),
                Text(
                  "${manga.capitulos.length} capítulo${manga.capitulos.length != 1 ? 's' : ''}",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: kDefaultMargin),
                const Divider(
                  height: 5,
                  color: Colors.white,
                ),
                Expanded(
                  child: CapitulosList(manga: manga),
                ),
              ],
            ),
          ),
          floatingActionButton: Wrap(
            direction: Axis.vertical,
            spacing: kDefaultMargin,
            children: [
              FloatingActionButton(
                heroTag: 'Adicionar Capítulo',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return CadastrarCapituloPage(mangaID: manga.id);
                      },
                    ),
                  ).then((_) => setState(() {}));
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                heroTag: 'Editar Mangá',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return CadastrarMangaPage(manga: manga);
                      },
                    ),
                  ).then((_) => setState(() {}));
                },
                backgroundColor: Colors.orangeAccent,
                child: const Icon(Icons.edit),
              ),
              FloatingActionButton(
                heroTag: 'Deletar Mangá',
                onPressed: () async {
                  final success = await mangaRepo.delete(manga.id);

                  if (success) {
                    print('Mangá deletado com sucesso!');
                  } else {
                    print('Falha ao deletar!');
                  }

                  Navigator.pop(context);
                },
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        );
      },
    );
  }
}
