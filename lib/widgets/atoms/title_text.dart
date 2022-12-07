import 'package:flutter/material.dart';

import 'text_styles.dart';

/// Title text to show as a bold headline
///
/// H is referred to <h1> from HTML web development
/// HH is referred to <h2> from HTML web development
/// HHH is referred to <h3> from HTML web development
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class _TitleText extends Text {
  const _TitleText(data, {TextStyle? style})
      : super(
          data,
          style: style,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        );
}

class TitleTextH extends StatelessWidget {
  final String text;

  const TitleTextH(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: TextStyles.titleMarginsH,
      child: _TitleText(
        text,
        style: TextStyles.titleH,
      ),
    );
  }
}

class TitleTextHH extends StatelessWidget {
  final String text;

  const TitleTextHH(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: TextStyles.titleMarginsHH,
      child: _TitleText(
        text,
        style: TextStyles.titleHH,
      ),
    );
  }
}

class TitleTextHHH extends StatelessWidget {
  final String text;

  const TitleTextHHH(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: TextStyles.titleMarginsHHH,
      child: _TitleText(
        text,
        style: TextStyles.titleHHH,
      ),
    );
  }
}
