import 'package:flutter/material.dart';

class FinmanTextFormField extends StatelessWidget {
  const FinmanTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.labelText,
    this.hintText,
    this.autofillHints,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final String? labelText;
  final String? hintText;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      autofillHints: autofillHints,
      decoration: InputDecoration(labelText: labelText, hintText: hintText),
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
