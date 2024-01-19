///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
abstract class Translator {
  /// Translate given text from sourceLanguage to targetLanguage
  Future<String> translate(String text, String sourceLanguage, String targetLanguage);

  /// Translate given text from auto detected language to targetLanguage
  Future<String> autoTranslateTo(String text, String targetLanguage);

  /// Get alphabetically sorted language keys with their english names that are available to use
  Map<String, String> getAvailableLanguages();
}
