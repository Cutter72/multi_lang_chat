import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_lang_chat/model/app_globals.dart';
import 'package:multi_lang_chat/model/app_user.dart';
import 'package:multi_lang_chat/widgets/screens/contacts_screen.dart';

import 'log_in_screen.dart';

var _isUserChangesListenerInitialized = false;

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AuthGateScreen extends StatelessWidget {
  static const routeName = "/auth-gate";

  const AuthGateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    initUserChangesListener();
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          initLoggedUser(snapshot.data);
          return const ContactsScreen();
        }
        return const LogInScreen();
      },
    );
  }

  void initUserChangesListener() {
    if (_isUserChangesListenerInitialized) {
      FirebaseAuth.instance.userChanges().listen((updatedUser) {
        initLoggedUser(updatedUser);
        db.collection("users").doc(loggedFirebaseUser.uid).get().then((snapshot) {
          var userData = snapshot.data();
          if (userData != null) {
            var oldAppUser = AppUser.fromSnapshotData(userData);
            if (loggedAppUser != oldAppUser) {
              db.collection("users").doc(loggedFirebaseUser.uid).update(loggedAppUser.toMap());
            }
          }
          return null;
        });
      });
    }
    _isUserChangesListenerInitialized = true;
  }

  void initLoggedUser(User? user) {
    if (user != null) {
      loggedFirebaseUser = user;
      loggedAppUser = AppUser.fromUser(user);
    }
  }
}
