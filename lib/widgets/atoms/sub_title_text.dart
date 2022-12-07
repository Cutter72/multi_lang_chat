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
class _SubTitleText extends Text {
  const _SubTitleText(data, {TextStyle? style})
      : super(
          data,
          style: style,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        );
}

class SubTitleTextH extends StatelessWidget {
  final String text;

  const SubTitleTextH(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: TextStyles.subTitleMarginsH,
      child: _SubTitleText(
        text,
        style: TextStyles.subTitleH,
      ),
    );
  }
}

class SubTitleTextHH extends StatelessWidget {
  final String text;

  const SubTitleTextHH(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: TextStyles.subTitleMarginsHH,
      child: _SubTitleText(
        text,
        style: TextStyles.subTitleHH,
      ),
    );
  }
}

class SubTitleTextHHH extends StatelessWidget {
  final String text;

  const SubTitleTextHHH(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: TextStyles.subTitleMarginsHHH,
      child: _SubTitleText(
        text,
        style: TextStyles.subTitleHHH,
      ),
    );
  }
}
