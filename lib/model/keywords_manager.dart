///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class KeywordsManager {
  Set<String> splitIntoKeywords(String data) {
    // All Except: [^
    // Any Letter In Any Language \p{L}
    // Digits \d
    // Whitespaces \s]
    //
    // r"[^\p{L}\d\s]"
    return (data.replaceAll(RegExp(r"[^\p{L}\d\s]", unicode: true), "").trim().split(RegExp(r"\s+"))
          ..removeWhere((keyword) => keyword.length < 3))
        .toSet();
  }
}
