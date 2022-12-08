import 'dart:collection';

import 'package:multi_lang_chat/model/firestore/keywords_manager.dart';
import 'package:test/test.dart';

/// KeywordsManager() test class
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
void main() {
  test(
      'splitIntoKeywords(String? data) splits the string into keywords list with min length of 3 chars and removed special chars',
      () {
    // GIVEN
    var givenData = ' fo o \t -,999, 112.12- \n b_ar \\ ,baz   加入百度 推广   14/R75    ąćń  صب الخير'
        ' 좋 은아침 baz \n `~!@#\$%^&*()_+-おはよ={}[]|\\:\';"<>?,./';
    var expected = ['999', '11212', 'bar', 'baz', '加入百度', '14R75', 'ąćń', 'الخير', '은아침', 'おはよ'];

    // WHEN
    var actual = KeywordsManager().splitIntoKeywords(givenData);

    // THEN
    expect(actual, equals(expected));
    expect(KeywordsManager().splitIntoKeywords(null), equals(HashSet()));
  });
}
