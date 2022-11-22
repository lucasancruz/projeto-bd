import 'package:app/repositories/manga_repository.dart';
import 'package:app/shared/constants.dart';
import 'package:app/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/my_text_form_field.dart';

class CadastrarCapituloPage extends StatefulWidget {
  const CadastrarCapituloPage({super.key, required this.mangaID});

  final int mangaID;

  @override
  State<CadastrarCapituloPage> createState() => _CadastrarCapituloPageState();
}

class _CadastrarCapituloPageState extends State<CadastrarCapituloPage> {
  final _formKey = GlobalKey<FormState>();
  final dataPublicacaoController = TextEditingController();
  final format = DateFormat("dd/MM/yyyy");

  String titulo = '';
  String numero = '';
  String url = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        centerTitle: true,
        title: Text(
          "Cadastrar Capítulo",
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
                labelText: "Número",
                initialValue: numero,
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {
                  numero = value;
                }),
                validator: requiredValidator,
              ),
              const SizedBox(height: kDefaultMargin),
              MyTextFormField(
                labelText: "Url",
                initialValue: url,
                onChanged: (value) => setState(() {
                  url = value;
                }),
                validator: requiredValidator,
              ),
              const SizedBox(height: kDefaultMargin),
              MyTextFormField(
                controller: dataPublicacaoController,
                labelText: "Data Criação",
                initialValue: null,
                readOnly: true,
                onChanged: (value) {},
                onTap: datePickerHandler(dataPublicacaoController),
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
                      'url': url,
                      'numero': int.parse(numero),
                      'data_publicacao': getIsoString(dataPublicacaoController),
                    };

                    final success = await mangaRepo.addChapter(data, widget.mangaID);

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
    return controller.text.isEmpty
        ? null
        : format.parse(controller.text).toUtc().toIso8601String();
  }
}
