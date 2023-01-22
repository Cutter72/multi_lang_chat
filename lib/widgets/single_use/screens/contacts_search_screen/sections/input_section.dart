import 'package:flutter/material.dart';

import '../../../../numerous_use/screens/sections/components/molecules/atoms/sub_title_text_atom.dart';
import '../../../../numerous_use/screens/sections/components/molecules/atoms/text_input_field_atom.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
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
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 4.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SubTitleTextHHH("Search by:"),
          TextInputField("Name", nameFieldController),
          TextInputField("Email", emailFieldController),
        ],
      ),
    );
  }
}
