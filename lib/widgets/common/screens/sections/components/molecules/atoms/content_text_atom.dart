import 'package:flutter/material.dart';

import '../../../../../../../storage/persistent/text_styles.dart';

/// Content text to show
///
/// H is referred to <h1> from HTML web development
/// HH is referred to <h2> from HTML web development
/// HHH is referred to <h3> from HTML web development
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class _ContentText extends Text {
  const _ContentText(data, {TextStyle? style})
      : super(
          data,
          style: style,
        );
}

class ContentTextH extends StatelessWidget {
  final String text;

  const ContentTextH(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: TextStyles.contentMarginsH,
      child: _ContentText(
        text,
        style: TextStyles.contentH,
      ),
    );
  }
}

class ContentTextHH extends StatelessWidget {
  final String text;

  const ContentTextHH(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: TextStyles.contentMarginsHH,
      child: _ContentText(
        text,
        style: TextStyles.contentHH,
      ),
    );
  }
}

class ContentTextHHH extends StatelessWidget {
  final String text;

  const ContentTextHHH(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: TextStyles.contentMarginsHHH,
      child: _ContentText(
        text,
        style: TextStyles.contentHHH,
      ),
    );
  }
}
