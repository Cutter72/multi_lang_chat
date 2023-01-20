import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/app_globals.dart';
import '../../model/firestore/app_user/app_user.dart';
import '../../model/firestore/db.dart';
import 'contacts_screen.dart';
import 'log_in_screen.dart';

var _isUserChangesListenerInitialized = false;

/// Widget to control authentication state and handle login/register flow.
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
          setupLoggedUserGlobally(snapshot.data);
          return const ContactsScreen();
        }
        return const LogInScreen();
      },
    );
  }

  void initUserChangesListener() {
    if (_isUserChangesListenerInitialized) {
      FirebaseAuth.instance.userChanges().listen((updatedUser) {
        setupLoggedUserGlobally(updatedUser);
        Db.users.doc(Db.luUid).get().then((snapshot) {
          var userData = snapshot.data();
          if (userData != null) {
            var oldAppUser = userData;
            if (loggedAppUser != oldAppUser) {
              Db.updateAppUserData(loggedAppUser);
            }
          }
          return null;
        });
      });
    }
    _isUserChangesListenerInitialized = true;
  }

  void setupLoggedUserGlobally(User? user) {
    if (user != null) {
      Db.loggedFirebaseUser = user;
      loggedAppUser = AppUser.fromUser(user);
    }
  }
}
