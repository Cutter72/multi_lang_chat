import 'keywords_manager.dart';

/// Class to store keywords for easier search in Firestore
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class Keywords {
  static const String keywordsKey = "_keywords";
  final Set<String> _keywords = {};

  Keywords({List<String?>? searchableTexts, Set<String>? keywords}) {
    var keywordsMgr = KeywordsManager();
    if (searchableTexts != null) {
      for (var searchableText in searchableTexts) {
        this._keywords.addAll(keywordsMgr.splitIntoKeywords(searchableText));
      }
    }
    if (keywords != null) {
      this._keywords.addAll(keywords);
    }
  }

  Map<String, dynamic> toMap() {
    return {keywordsKey: _keywords.toList()};
  }
}
