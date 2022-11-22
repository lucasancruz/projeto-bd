import 'package:app/models/editora.dart';
import 'package:app/pages/cadastrar_editora_page.dart';
import 'package:app/repositories/editora_repository.dart';
import 'package:flutter/material.dart';

class EditorasPage extends StatefulWidget {
  const EditorasPage({super.key});

  @override
  State<EditorasPage> createState() => _EditorasPageState();
}

class _EditorasPageState extends State<EditorasPage> {
  @override
  Widget build(BuildContext context) {
    final editoraRepo = EditoraRepository();

    return Scaffold(
      body: FutureBuilder(
          future: editoraRepo.findAll(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            final List<Editora> editoras = snapshot.data as List<Editora>;

            return ListView.builder(
              itemCount: editoras.length,
              itemBuilder: (ctx, index) {
                final editora = editoras[index];

                return ListTile(
                  title: Text(
                    editora.nome,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white),
                  ),
                );
              },
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
                builder: (ctx) => const CadastrarEditoraPage(),
              ),
            ).then((value) => setState(() {}));
          },
        ),
      ),
    );
  }
}
