import 'package:dart_mappable/dart_mappable.dart';

import 'keywords_manager.dart';

/// Class to store keywords for easier search in Firestore
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class Keywords {
  static const String keywordsKey = "_keywords";
  @MappableField(key: "_keywords")
  late final Set<String> keywords;

  Keywords(this.keywords);

  Keywords.from({List<String?>? searchableTexts, Set<String>? keywords}) {
    this.keywords = {};
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
}
