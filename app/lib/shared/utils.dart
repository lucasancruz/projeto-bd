  String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Esse campo é obrigatório';
    }

    return null;
  }
