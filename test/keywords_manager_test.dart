import 'package:multi_lang_chat/model/keywords_manager.dart';
import 'package:test/test.dart';

/// KeywordsManager() test class
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
void main() {
  test('splitIntoKeywords(String data) splits the string into keywords list with min length of 3 chars', () {
    var data = ' fo o \t  , \n b_ar \\ ,baz  \n `~!@#\$%^&*()_+-={}[]|\\:\';"<>?,./';
    expect(KeywordsManager().splitIntoKeywords(data), equals(['b_ar', 'baz']));
  });
}
