import 'package:flutter/material.dart';

import 'content_text.dart';

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
    return Center(
      child: ContentTextHHH("Something went wrong: $error"),
    );
  }
}
