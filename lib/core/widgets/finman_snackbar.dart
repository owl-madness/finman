import 'package:flutter/material.dart';

class FinmanSnackbar {
  const FinmanSnackbar._();

  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }

  static void showSuccess(BuildContext context, {required String message}) {
    _show(context, message: message, backgroundColor: Colors.green);
  }

  static void showError(BuildContext context, {required String message}) {
    _show(
      context,
      message: message,
      backgroundColor: Theme.of(context).colorScheme.error,
    );
  }

  static void showWarning(BuildContext context, {required String message}) {
    _show(context, message: message, backgroundColor: Colors.orange);
  }

  static void showInfo(BuildContext context, {required String message}) {
    _show(context, message: message, backgroundColor: Colors.blue);
  }
}
