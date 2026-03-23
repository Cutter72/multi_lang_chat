import 'dart:collection';

import 'package:multi_lang_chat/model/actives/keywords_splitter.dart';
import 'package:test/test.dart';

/// KeywordsSplitter() test class
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
void main() {
  test(
      'splitIntoKeywords(String? data) splits the string into keywords list with min length of 3 chars and removed special chars',
      () {
    // GIVEN
    var givenData =
        ' fo o \t -,999, 112.12- \n b_ar \\ ,baz   加入百度 推广   14/R75    ąćń  صب الخير'
        ' 좋 은아침 baz \n `~!@#\$%^&*()_+-おはよ={}[]|\\:\';"<>?,./';
    var expected = [
      '999',
      '112',
      'baz',
      '加入百度',
      'r75',
      'ąćń',
      'الخير',
      '은아침',
      'おはよ'
    ];

    // WHEN
    var actual = KeywordsSplitter().splitIntoKeywords(givenData);

    // THEN
    expect(actual, equals(expected));
    expect(KeywordsSplitter().splitIntoKeywords(null), equals(HashSet()));
  });
}
