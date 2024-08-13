// External packages
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

mixin DialogMixin<T extends StatefulWidget> on State<T> {
  void showLoadingIndicator() {
    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> showSuccessMessage(String content) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content.i18n()),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

// Show error message snackbar
  Future<void> showErrorMessage(String error) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.i18n()),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
