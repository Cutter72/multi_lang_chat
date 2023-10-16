import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../../../model/actives/app_logger.dart';
import '../../../model/passives/daos/app_user/app_user.dart';
import '../../../storage/persistent/firestore/db.dart';
import '../../../storage/runtime/app_globals.dart';
import 'contacts_screen/contacts_screen.dart';
import 'log_in_screen.dart';

var _isUserChangesListenerInitialized = false;

/// Widget to control authentication state and handle login/register flow.
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("AuthGateScreen");

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
    _logger.v("initUserChangesListener");
    if (_isUserChangesListenerInitialized) {
      FirebaseAuth.instance.userChanges().listen((updatedUser) {
        setupLoggedUserGlobally(updatedUser);
        Db.users.doc(lauUid).get().then((snapshot) {
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
    _logger.v("setupLoggedUserGlobally");
    if (user != null) {
      Db.loggedFirebaseUser = user;
      loggedAppUser = AppUser.fromUser(user);
      FirebaseCrashlytics.instance.setUserIdentifier("${loggedAppUser.email}, ${loggedAppUser.uid}");
    }
  }
}
