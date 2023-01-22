import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String labelText;

  final TextEditingController controller;

  const TextInputField(
    this.labelText,
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TextField(
          maxLines: 1,
          decoration: InputDecoration(
              labelText: labelText, border: const OutlineInputBorder(), contentPadding: const EdgeInsets.all(8)),
          controller: controller,
        ));
  }
}
