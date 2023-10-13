import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:logging/logging.dart';
import 'package:logging_to_logcat/logging_to_logcat.dart';

import 'firebase_options.dart';
import 'storage/persistent/firestore/db.dart';
import 'storage/runtime/app_globals.dart';
import 'widgets/single_use/screens/app_root_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
void main() async {
  await initLogger();
  await initFirebase();
  await initCrashlytics();
  await initLocale();
  initFirebaseAuthUiProviders();
  runApp(const AppRootScreen());
}

Future<void> initLogger() async {
  Logger.root.level = Level.ALL;
  if (Platform.isAndroid) {
    await Logger.root.activateLogcat();
  } else {
    Logger.root.onRecord.listen((record) {
      // Logs can be intercepted here and used i.e. to write them to file
      // Print to console if not Android platform
      print(record.message);
    });
  }
}

bool _isLocaleInitialized = false;
bool _isFirebaseInitialized = false;

Future<void> initFirebase() async {
  if (!_isFirebaseInitialized) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Db.instance = FirebaseFirestore.instance;
    _isFirebaseInitialized = true;
  }
}

Future<void> initCrashlytics() async {
  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return false;
  };
}

Future<void> initLocale() async {
  if (!_isLocaleInitialized) {
    await findSystemLocale();
    await initializeDateFormatting(Intl.systemLocale);
    _isLocaleInitialized = true;
  }
}

void initFirebaseAuthUiProviders() {
  FirebaseUIAuth.configureProviders(authProviders);
}
