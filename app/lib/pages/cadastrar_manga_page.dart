import 'package:app/components/my_text_form_field.dart';
import 'package:app/models/editora.dart';
import 'package:app/repositories/editora_repository.dart';
import 'package:app/repositories/manga_repository.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastrarMangaPage extends StatefulWidget {
  const CadastrarMangaPage({super.key});

  @override
  State<CadastrarMangaPage> createState() => _CadastrarMangaPageState();
}

class _CadastrarMangaPageState extends State<CadastrarMangaPage> {
  final _formKey = GlobalKey<FormState>();
  final dataCriacaoController = TextEditingController();
  final dataFinalizacaoController = TextEditingController();

  final mangaRepo = MangaRepository();
  final editoraRepo = EditoraRepository();

  String titulo = '';
  String sinopse = '';
  String imagem = '';
  int? editoraId = null;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        centerTitle: true,
        title: Text(
          "Cadastrar Mangá",
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
                initialValue: '',
                onChanged: (value) => setState(() {
                  titulo = value;
                }),
                validator: requiredValidator,
              ),
              const SizedBox(height: kDefaultMargin),
              MyTextFormField(
                labelText: "Sinopse",
                initialValue: '',
                onChanged: (value) => setState(() {
                  sinopse = value;
                }),
                validator: requiredValidator,
              ),
              const SizedBox(height: kDefaultMargin),
              MyTextFormField(
                labelText: "Imagem",
                initialValue: '',
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
                future: editoraRepo.findAll(),
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

                    final Map<String, dynamic> data = {
                      'titulo': titulo,
                      'sinopse': sinopse,
                      'imagem': imagem,
                      'dataCriacao': getDate(dataCriacaoController),
                      'dataFinalizacao': getDate(dataFinalizacaoController),
                      'editora_id': editoraId,
                    };

                    final success = await mangaRepo.create(data);

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
                        : const Text(
                            "Cadastrar",
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

  String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Esse campo é obrigatório';
    }

    return null;
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
        String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);

        setState(() {
          controller.text = formattedDate;
        });
      }
    };
  }

  DateTime? getDate(TextEditingController controller) {
    final format = DateFormat("dd/MM/yyyy");

    return controller.text.isEmpty
        ? null
        : format.parse(controller.text);
  }
}
