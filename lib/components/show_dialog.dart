import 'package:flutter/material.dart';

class ShowDialog extends StatelessWidget {
  final errorMessage;
  final errorTitle;

  const ShowDialog({super.key, required this.errorMessage, this.errorTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(errorTitle ?? "Xatolik"),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dialogni yopish
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
