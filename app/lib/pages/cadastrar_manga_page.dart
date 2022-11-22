import 'package:app/components/my_text_form_field.dart';
import 'package:app/models/editora.dart';
import 'package:app/models/manga.dart';
import 'package:app/repositories/editora_repository.dart';
import 'package:app/repositories/manga_repository.dart';
import 'package:app/shared/constants.dart';
import 'package:app/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastrarMangaPage extends StatefulWidget {
  const CadastrarMangaPage({super.key, this.manga});

  final Manga? manga;

  @override
  State<CadastrarMangaPage> createState() => _CadastrarMangaPageState();
}

class _CadastrarMangaPageState extends State<CadastrarMangaPage> {
  final _formKey = GlobalKey<FormState>();
  final dataCriacaoController = TextEditingController();
  final dataFinalizacaoController = TextEditingController();
  final format = DateFormat("dd/MM/yyyy");

  final editoraRepo = EditoraRepository();
  Future<List<Editora>>? editorasFuture;

  late String titulo;
  late String sinopse;
  late String imagem;
  int? editoraId;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    titulo = widget.manga?.titulo ?? '';
    sinopse = widget.manga?.sinopse ?? '';
    imagem = widget.manga?.imagem ?? '';
    editoraId = widget.manga?.editoraID;
    dataCriacaoController.text = widget.manga?.dataCriacao != null ? format.format(widget.manga!.dataCriacao!) : '';
    dataFinalizacaoController.text = widget.manga?.dataFinalizacao != null ? format.format(widget.manga!.dataFinalizacao!) : '';

    loadData();
    print(widget.manga?.dataCriacao);
  }

  Future<void> loadData() async {
    editorasFuture = editoraRepo.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        centerTitle: true,
        title: Text(
          widget.manga == null ? "Cadastrar Mangá" : "Atualizar Mangá",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyTextFormField(
                labelText: "Título",
                initialValue: titulo,
                onChanged: (value) => setState(() {
                  titulo = value;
                }),
                validator: requiredValidator,
              ),
              const SizedBox(height: kDefaultMargin),
              MyTextFormField(
                labelText: "Sinopse",
                initialValue: sinopse,
                onChanged: (value) => setState(() {
                  sinopse = value;
                }),
                validator: requiredValidator,
              ),
              const SizedBox(height: kDefaultMargin),
              MyTextFormField(
                labelText: "Imagem",
                initialValue: imagem,
                onChanged: (value) => setState(() {
                  imagem = value;
                }),
                validator: requiredValidator,
              ),
              const SizedBox(height: kDefaultMargin),
              MyTextFormField(
                controller: dataCriacaoController,
                labelText: "Data Criação",
                initialValue: null,
                readOnly: true,
                onChanged: (value) {},
                onTap: datePickerHandler(dataCriacaoController),
              ),
              const SizedBox(height: kDefaultMargin),
              MyTextFormField(
                controller: dataFinalizacaoController,
                labelText: "Data Finalização",
                initialValue: null,
                readOnly: true,
                onChanged: (value) => {},
                onTap: datePickerHandler(dataFinalizacaoController),
              ),
              const SizedBox(height: kDefaultMargin),
              FutureBuilder(
                future: editorasFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  final List<Editora> editoras = snapshot.data as List<Editora>;

                  return DropdownButtonFormField<int>(
                    value: editoraId,
                    dropdownColor: Theme.of(context).primaryColorDark,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      final List<int> ids =
                          editoras.map<int>((editora) => editora.id).toList();

                      if (value == null || !ids.contains(value)) {
                        return 'Esse campo é obrigatório';
                      }

                      return null;
                    },
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                    hint: Text(
                      "Selecione a editora",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                    items: editoras.map<DropdownMenuItem<int>>((editora) {
                      return DropdownMenuItem(
                        value: editora.id,
                        child: Text(editora.nome),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        editoraId = value as int;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: kDefaultMargin * 4),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });

                    final mangaRepo = MangaRepository();

                    final Map<String, dynamic> data = {
                      'titulo': titulo,
                      'sinopse': sinopse,
                      'imagem': imagem,
                      'data_criacao': getIsoString(dataCriacaoController),
                      'data_finalizacao': getIsoString(dataFinalizacaoController),
                      'editora_id': editoraId,
                    };

                    print(data);

                    final success = widget.manga == null
                        ? await mangaRepo.create(data)
                        : await mangaRepo.update(data, widget.manga!.id);

                    if (success) {
                      _formKey.currentState!.reset();
                    }

                    setState(() {
                      loading = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Center(
                    child: loading
                        ? const CircularProgressIndicator()
                        : Text(
                            widget.manga == null ? "Cadastrar" : "Atualizar",
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Function()? datePickerHandler(TextEditingController controller) {
    return () async {
      final now = DateTime.now();

      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1900, 1, 1, 1),
        lastDate: now,
      );

      if (selectedDate != null) {
        String formattedDate = format.format(selectedDate);

        setState(() {
          controller.text = formattedDate;
        });
      }
    };
  }

  String? getIsoString(TextEditingController controller) {
    return controller.text.isEmpty ? null : format.parse(controller.text).toUtc().toIso8601String();
  }
}
