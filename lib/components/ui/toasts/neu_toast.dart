import 'package:flutter/material.dart';

class NeuToast extends StatelessWidget {
  const NeuToast({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
