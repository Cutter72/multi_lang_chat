import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

import 'firebase_options.dart';
import 'widgets/screens/app_root.dart';

late FirebaseFirestore db;
final List<AuthProvider> authProviders = [EmailAuthProvider()];
bool _isLocaleInitialized = false;
bool _isFirebaseInitialized = false;

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

void main() async {
  await initFirebase();
  await initLocale();
  initFirebaseAuthUiProviders();
  runApp(const AppRoot());
}

Future initFirebase() async {
  if (!_isFirebaseInitialized) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    db = FirebaseFirestore.instance;
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
