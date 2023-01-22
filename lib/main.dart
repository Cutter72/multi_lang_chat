import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

import 'firebase_options.dart';
import 'storage/persistent/firestore/db.dart';
import 'storage/runtime/app_globals.dart';
import 'widgets/single_use/screens/app_root_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
void main() async {
  await initFirebase();
  await initLocale();
  initFirebaseAuthUiProviders();
  runApp(const AppRootScreen());
}

bool _isLocaleInitialized = false;
bool _isFirebaseInitialized = false;

Future initFirebase() async {
  if (!_isFirebaseInitialized) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Db.instance = FirebaseFirestore.instance;
    _isFirebaseInitialized = true;
  }
}

Future initLocale() async {
  if (!_isLocaleInitialized) {
    await findSystemLocale();
    await initializeDateFormatting(Intl.systemLocale);
    _isLocaleInitialized = true;
  }
}

void initFirebaseAuthUiProviders() {
  FirebaseUIAuth.configureProviders(authProviders);
}
