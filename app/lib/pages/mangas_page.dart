import 'package:app/components/manga_card.dart';
import 'package:app/models/manga.dart';
import 'package:app/pages/cadastrar_manga_page.dart';
import 'package:app/pages/manga_detail_page.dart';
import 'package:app/repositories/manga_repository.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';

class MangasPage extends StatefulWidget {
  const MangasPage({super.key});

  @override
  State<MangasPage> createState() => _MangasPageState();
}

class _MangasPageState extends State<MangasPage> {
  final MangaRepository mangaRepo = MangaRepository();
  Future<List<Manga>>? mangasFuture;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    mangasFuture = mangaRepo.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: mangasFuture,
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
              children: mangas
                  .map(
                    (manga) => InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) {
                              return MangaDetailPage(id: manga.id);
                            },
                          ),
                        ).then((value) => setState(() {}));
                      },
                      child: MangaCard(manga: manga),
                    ),
                  )
                  .toList(),
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
            ).then((value) => setState(() {
              loadData();
            }));
          },
        ),
      ),
    );
  }
}
