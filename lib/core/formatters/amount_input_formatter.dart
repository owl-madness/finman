import 'package:flutter/services.dart';

class AmountInputFormatter {
  AmountInputFormatter._();

  static TextInputFormatter decimal({
    int decimalRange = 2,
  }) {
    return TextInputFormatter.withFunction(
      (oldValue, newValue) {
        final text = newValue.text;

        // Allow empty field
        if (text.isEmpty) {
          return newValue;
        }

        // Allow only one decimal point
        if ('.'.allMatches(text).length > 1) {
          return oldValue;
        }

        final parts = text.split('.');

        // More than one '.' found
        if (parts.length > 2) {
          return oldValue;
        }

        // Limit decimal places
        if (parts.length == 2 && parts[1].length > decimalRange) {
          return oldValue;
        }

        // Allow only digits and decimal point
        if (!RegExp(r'^\d*\.?\d*$').hasMatch(text)) {
          return oldValue;
        }

        return newValue;
      },
    );
  }
}
