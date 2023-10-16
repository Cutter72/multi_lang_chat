import 'app_logger.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("KeywordsSplitter");

class KeywordsSplitter {
  Set<String> splitIntoKeywords(String? data) {
    _logger.v("splitIntoKeywords");
    // All Except: [^
    // Any Letter In Any Language \p{L}
    // Digits \d
    // Whitespaces \s]
    //
    // r"[^\p{L}\d\s]"
    if (data != null && data.length >= 3) {
      return (data.replaceAll(RegExp(r"[^\p{L}\d\s]", unicode: true), "").trim().split(RegExp(r"\s+"))
            ..removeWhere((keyword) => keyword.length < 3))
          .toSet();
    } else {
      return {};
    }
  }
}
