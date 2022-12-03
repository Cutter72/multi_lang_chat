import 'package:flutter/material.dart';

import 'text_styles.dart';

/// Content text to show
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContentTextH extends StatelessWidget {
  final String text;

  const ContentTextH({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.contentH,
    );
  }
}

class ContentTextHH extends StatelessWidget {
  final String text;

  const ContentTextHH({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.contentHH,
    );
  }
}

class ContentTextHHH extends StatelessWidget {
  final String text;

  const ContentTextHHH({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.contentHHH,
    );
  }
}
