///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
abstract class Translator {
  /// Initializes a translator
  void init();

  /// Translate given text from sourceLanguage to targetLanguage
  Future<String> translate(String text, String sourceLanguage, String targetLanguage);

  /// Translate given text from auto detected language to targetLanguage
  Future<String> autoTranslateTo(String text, String targetLanguage);

  /// Get alphabetically sorted languages available to use
  Map<String, String> getAvailableLanguages();
}
