import 'package:flutter/material.dart';

/// Text styles for entire app
///
/// H is referred to <h1> from HTML web development
/// HH is referred to <h2> from HTML web development
/// HHH is referred to <h3> from HTML web development
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class TextStyles {
  /// Text font sizes
  static const double _em = 4;
  static const double _titleSizeH = 6 * _em;
  static const double _titleSizeHH = 5 * _em;
  static const double _titleSizeHHH = 4 * _em;
  static const double _subTitleSizeH = 5.33 * _em;
  static const double _subTitleSizeHH = 4.33 * _em;
  static const double _subTitleSizeHHH = 3.33 * _em;
  static const double _contentSizeH = 5 * _em;
  static const double _contentSizeHH = 4 * _em;
  static const double _contentSizeHHH = 3 * _em;

  /// Text styles
  static const TextStyle titleH = TextStyle(fontSize: _titleSizeH, color: Colors.black, fontWeight: FontWeight.w700);
  static const TextStyle titleHH = TextStyle(fontSize: _titleSizeHH, color: Colors.black, fontWeight: FontWeight.w700);
  static const TextStyle titleHHH =
      TextStyle(fontSize: _titleSizeHHH, color: Colors.black, fontWeight: FontWeight.w700);
  static const TextStyle subTitleH = TextStyle(
      fontSize: _subTitleSizeH, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500);
  static const TextStyle subTitleHH = TextStyle(
      fontSize: _subTitleSizeHH, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500);
  static const TextStyle subTitleHHH = TextStyle(
      fontSize: _subTitleSizeHHH, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500);
  static const TextStyle contentH =
      TextStyle(fontSize: _contentSizeH, color: Colors.black, fontWeight: FontWeight.w400);
  static const TextStyle contentHH =
      TextStyle(fontSize: _contentSizeHH, color: Colors.black, fontWeight: FontWeight.w400);
  static const TextStyle contentHHH =
      TextStyle(fontSize: _contentSizeHHH, color: Colors.black, fontWeight: FontWeight.w400);
}
