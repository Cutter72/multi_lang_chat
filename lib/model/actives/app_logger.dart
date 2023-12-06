import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logging/logging.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AppLogger {
  final FirebaseCrashlytics _crashlytics;

  final Logger _logger;
  final Function _logFormat;
  final String _className;

  const AppLogger._create(logFormat, logging, className, crashlytics)
      : _logFormat = logFormat,
        _logger = logging,
        _className = className,
        _crashlytics = crashlytics;

  factory AppLogger.get(String className) {
    if (Platform.isAndroid) {
      return AppLogger._create(_androidFormat, Logger(className), className, FirebaseCrashlytics.instance);
    } else {
      return AppLogger._create(_otherFormat, Logger(className), className, FirebaseCrashlytics.instance);
    }
  }

  void v(Object? message, {Object? tag, Object? error, StackTrace? stackTrace}) {
    _log(Level.FINE, "V", message, tag: tag);
  }

  void d(Object? message, {Object? tag, Object? error, StackTrace? stackTrace}) {
    _log(Level.CONFIG, "D", message, tag: tag);
  }

  void i(Object? message, {Object? tag, Object? error, StackTrace? stackTrace}) {
    _log(Level.INFO, "I", message, tag: tag);
  }

  void w(Object? message, {Object? tag, Object? error, StackTrace? stackTrace}) {
    _log(Level.WARNING, "W", message, tag: tag);
  }

  void e(Object? message, {Object? tag, Object? error, StackTrace? stackTrace}) {
    _log(Level.SEVERE, "E", message, tag: tag);
  }

  eAsync(Object? message, {Object? tag, Object? error, StackTrace? stackTrace}) async {
    _log(Level.SEVERE, "E", message, tag: tag);
  }

  void wtf(Object? message, {Object? tag, Object? error, StackTrace? stackTrace}) {
    _log(Level.SHOUT, "WTF", message, tag: tag);
  }

  void _log(Level logLevel, String levelSymbol, Object? message, {Object? tag, Object? error, StackTrace? stackTrace}) {
    _crashlytics.log(_otherFormat(_className, levelSymbol, tag, message));
    _logger.log(logLevel, _logFormat(_className, levelSymbol, tag, message), error, stackTrace);
  }

  static String _androidFormat(Object? className, Object? levelSymbol, Object? tag, Object? message) =>
      "${_prepareCustomTag(tag)}$message";

  static String _otherFormat(Object? className, Object? levelSymbol, Object? tag, Object? message) =>
      "$levelSymbol/$className: ${_prepareCustomTag(tag)}$message";

  static String _prepareCustomTag(Object? tag) => tag != null ? "[$tag] " : "";
}
