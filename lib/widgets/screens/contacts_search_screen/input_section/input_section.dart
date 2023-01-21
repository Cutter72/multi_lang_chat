import 'package:flutter/material.dart';

import '../../../atoms/sub_title_text.dart';
import '../../../atoms/text_input_field.dart';

class InputSection extends StatelessWidget {
  const InputSection({
    Key? key,
    required this.nameFieldController,
    required this.emailFieldController,
  }) : super(key: key);

  final TextEditingController nameFieldController;
  final TextEditingController emailFieldController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SubTitleTextHHH("Search by:"),
        TextInputField("Name", nameFieldController),
        TextInputField("Email", emailFieldController),
      ],
    );
  }
}
