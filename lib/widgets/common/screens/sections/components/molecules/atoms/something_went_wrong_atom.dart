import 'package:flutter/material.dart';

import 'content_text_atom.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class SomethingWentWrong extends StatelessWidget {
  final Object error;

  const SomethingWentWrong(
    this.error, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ContentTextHHH("Something went wrong:\n$error"),
      ),
    );
  }
}
