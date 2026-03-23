///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
abstract class Translator {
  /// Translate given text from sourceLanguage (auto detect if absent)
  /// to targetLanguage (default value if absent).
  Future<String> translate(
    String text, {
    String? sourceLanguage,
    String? targetLanguage,
  });

  /// Get alphabetically sorted language keys with their
  /// english names that are available to use for example 'en' - 'English'
  Map<String, String> getAvailableLanguages();

  /// Parse language name to language key for example 'English' to 'en'
  String parseToLanguageKey(String language);

  /// Return default language key for example 'en'
  String getDefaultTargetLanguageKey();

  /// Set default language key for example 'en'
  void setDefaultTargetLanguageKey(String languageKey);
}
