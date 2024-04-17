import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.inputFormatters,
    this.validator,
    this.onTap,
    this.customDecoration,
    this.readOnly = false,
    this.numberKeyboard = false,
  });

  final String? hintText;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Future<Null> Function()? onTap;
  final InputDecoration? customDecoration;
  final bool readOnly;
  final bool numberKeyboard;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: controller,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          keyboardType:
              numberKeyboard ? TextInputType.number : TextInputType.text,
          validator: validator,
          onTap: onTap,
          decoration: customDecoration is InputDecoration
              ? customDecoration
              : InputDecoration(hintText: hintText),
        ));
  }
}
