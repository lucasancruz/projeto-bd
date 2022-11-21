import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.initialValue,
    required this.onChanged,
    required this.labelText,
    this.hintText,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.controller,
  });

  final String? initialValue;
  final Function(String)? onChanged;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool readOnly;
  final void Function()? onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      cursorColor: Theme.of(context).primaryColor,
      readOnly: readOnly,
      onTap: onTap,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle:
            Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),
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
    );
  }
}
