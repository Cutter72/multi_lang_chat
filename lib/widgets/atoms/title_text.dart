import 'package:flutter/material.dart';

import 'text_styles.dart';

/// Title text to show as a bold headline
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class TitleTextH extends StatelessWidget {
  final String text;

  const TitleTextH({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.titleH,
    );
  }
}

class TitleTextHH extends StatelessWidget {
  final String text;

  const TitleTextHH({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.titleHH,
    );
  }
}

class TitleTextHHH extends StatelessWidget {
  final String text;

  const TitleTextHHH({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.titleHHH,
    );
  }
}
