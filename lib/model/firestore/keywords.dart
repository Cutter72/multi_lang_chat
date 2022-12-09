import 'keywords_manager.dart';

/// Class to store keywords for easier search in Firestore
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class Keywords {
  static const String keywordsKey = "_keywords";
  final Set<String> keywords = {};

  Keywords({List<String?>? searchableTexts, Set<String>? keywords}) {
    var keywordsMgr = KeywordsManager();
    if (searchableTexts != null) {
      for (var searchableText in searchableTexts) {
        this.keywords.addAll(keywordsMgr.splitIntoKeywords(searchableText));
      }
    }
    if (keywords != null) {
      this.keywords.addAll(keywords);
    }
  }

  Map<String, dynamic> toMap() {
    return {keywordsKey: keywords.toList()};
  }

  @override
  String toString() {
    return 'Keywords{_keywords: $keywords}';
  }
}
