import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logging/logging.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AppLogger {
  final _crashlytics = FirebaseCrashlytics.instance;
  late final Logger _logging;
  late final Function logFormat;

  final String className;

  AppLogger(this.className) {
    _logging = Logger(className);
    if (Platform.isAndroid) {
      logFormat = _androidFormat;
    } else {
      logFormat = _otherFormat;
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

  void wtf(Object? message, {Object? tag, Object? error, StackTrace? stackTrace}) {
    _log(Level.SHOUT, "WTF", message, tag: tag);
  }

  void _log(Level logLevel, String levelSymbol, Object? message, {Object? tag, Object? error, StackTrace? stackTrace}) {
    _crashlytics.log(_otherFormat(levelSymbol, tag, message));
    _logging.log(logLevel, logFormat(levelSymbol, tag, message), error, stackTrace);
  }

  String _androidFormat(Object? levelSymbol, Object? tag, Object? message) => "${_prepareTag(tag)}$message";

  String _otherFormat(Object? levelSymbol, Object? tag, Object? message) =>
      "$levelSymbol/$className: ${_prepareTag(tag)}$message";

  String _prepareTag(Object? tag) => tag != null ? "[$tag] " : "";
}
