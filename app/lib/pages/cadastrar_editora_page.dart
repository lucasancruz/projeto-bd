import 'package:app/repositories/editora_repository.dart';
import 'package:app/shared/constants.dart';
import 'package:app/shared/utils.dart';
import 'package:flutter/material.dart';

import '../components/my_text_form_field.dart';

class CadastrarEditoraPage extends StatefulWidget {
  const CadastrarEditoraPage({super.key});

  @override
  State<CadastrarEditoraPage> createState() => _CadastrarEditoraPageState();
}

class _CadastrarEditoraPageState extends State<CadastrarEditoraPage> {
  final _formKey = GlobalKey<FormState>();

  String nome = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        centerTitle: true,
        title: Text(
          "Cadastrar Editora",
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
                labelText: "Nome",
                initialValue: nome,
                onChanged: (value) => setState(() {
                  nome = value;
                }),
                validator: requiredValidator,
              ),
              const SizedBox(height: kDefaultMargin),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });

                    final editoraRepo = EditoraRepository();

                    final Map<String, dynamic> data = {
                      'nome': nome,
                    };

                    final success = await editoraRepo.create(data);

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
}
