import 'package:flutter/material.dart';

class AppSnackBar extends StatelessWidget {
  final String errorMessage;
  const AppSnackBar({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      margin: const EdgeInsets.all(8),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(
        errorMessage,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
