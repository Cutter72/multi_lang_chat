///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class KeywordsManager {
  Set<String> splitIntoKeywords(String data) {
    return (data.replaceAll(RegExp(r"\W"), " ").trim().split(RegExp(r"\s+"))
          ..removeWhere((keyword) => keyword.length < 3))
        .toSet();
  }
}
