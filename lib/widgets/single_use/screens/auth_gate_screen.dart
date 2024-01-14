import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../../../model/actives/app_logger.dart';
import '../../../model/passives/daos/app_user/app_user.dart';
import '../../../storage/persistent/firestore/db.dart';
import '../../../storage/persistent/firestore/providers/contacts_provider.dart';
import '../../../storage/runtime/app_globals.dart';
import 'contacts_screen/contacts_screen.dart';
import 'log_in_screen.dart';

/// Widget to control authentication state and handle login/register flow.
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("AuthGateScreen");
var _isUserChangesListenerInitialized = false;

class AuthGateScreen extends StatelessWidget {
  static const routeName = "/auth-gate";

  const AuthGateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _initUserDataChangeListener();
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _setupLoggedUserGlobally(snapshot.data);
          return const ContactsScreen();
        }
        return const AuthenticationScreen();
      },
    );
  }

  void _initUserDataChangeListener() {
    _logger.v("_initUserDataChangeListener");
    if (_isUserChangesListenerInitialized) {
      _logger.v("_initUserDataChangeListener");
      FirebaseAuth.instance.userChanges().listen(_userDataChangeListener);
    }
    _isUserChangesListenerInitialized = true;
  }

  void _userDataChangeListener(updatedUser) {
    _logger.v("_userChangeListener");
    if (updatedUser != null) {
      _setupLoggedUserGlobally(updatedUser);
      Db.users.doc(lauUid).get().then((snapshot) {
        if (_isUserDataOutdated(snapshot.data())) {
          Db.updateAppUserData(loggedAppUser);
        }
        return null;
      });
    } else {
      _logger.v("User not logged");
    }
  }

  bool _isUserDataOutdated(AppUser? oldAppUserData) {
    var isUserDataOutdated =
        oldAppUserData != null && loggedAppUser != oldAppUserData;
    _logger.d("_isUserDataOutdated: $isUserDataOutdated");
    return isUserDataOutdated;
  }

  void _setupLoggedUserGlobally(User? user) {
    if (user != null) {
      _logger.d("_setupLoggedUserGlobally: ${user.uid}");
      Db.loggedFirebaseUser = user;
      loggedAppUser = AppUser.fromUser(user);
      FirebaseCrashlytics.instance
          .setUserIdentifier("${loggedAppUser.email}, ${loggedAppUser.uid}");
      ContactsProvider.resetCachedContacts();
    }
  }
}
