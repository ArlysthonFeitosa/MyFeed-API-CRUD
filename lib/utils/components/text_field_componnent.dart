import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    Key? key,
    required this.hint,
    this.autovalidateMode,
    this.onChanged,
    this.controller,
    this.icon,
    this.inputType,
    this.validation,
    this.capitalization = TextCapitalization.none,
  }) : super(key: key);

  final String hint;
  final Function(String?)? onChanged;
  final TextCapitalization capitalization;
  final TextEditingController? controller;
  final IconData? icon;
  final TextInputType? inputType;
  final String? Function(String?)? validation;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      validator: validation,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      textCapitalization: capitalization,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
      ),
    );
  }
}
