///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
abstract class Translator {
  /// Translate given text from sourceLanguage to targetLanguage
  String translate(String text, String sourceLanguage, String targetLanguage);

  /// Translate given text from auto detected language to targetLanguage
  String autoTranslateTo(String text, String targetLanguage);

  /// Get alphabetically sorted languages available to use
  List<String> getAvailableLanguages();
}
