import 'package:app/components/manga_card.dart';
import 'package:app/models/manga.dart';
import 'package:app/pages/cadastrar_manga_page.dart';
import 'package:app/repositories/manga_repository.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';

class MangasPage extends StatelessWidget {
  MangasPage({super.key});

  final MangaRepository mangaRepo = MangaRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: mangaRepo.findAll(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            final List<Manga> mangas = snapshot.data as List<Manga>;

            return GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(kDefaultPadding),
              crossAxisSpacing: kDefaultMargin,
              mainAxisSpacing: kDefaultMargin,
              childAspectRatio: 140 / 192,
              children: mangas.map((manga) => MangaCard(manga: manga)).toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const CadastrarMangaPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
