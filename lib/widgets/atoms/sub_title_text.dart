import 'package:flutter/material.dart';

import 'text_styles.dart';

/// Sub title text to show under the title texts
///
/// H is referred to <h1> from HTML web development
/// HH is referred to <h2> from HTML web development
/// HHH is referred to <h3> from HTML web development
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class SubTitleTextH extends StatelessWidget {
  final String text;

  const SubTitleTextH({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.subTitleH,
    );
  }
}

class SubTitleTextHH extends StatelessWidget {
  final String text;

  const SubTitleTextHH({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.subTitleHH,
    );
  }
}

class SubTitleTextHHH extends StatelessWidget {
  final String text;

  const SubTitleTextHHH({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.subTitleHHH,
    );
  }
}
