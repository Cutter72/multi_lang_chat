import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../../../model/actives/app_logger.dart';
import '../../../model/passives/daos/app_user/app_user.dart';
import '../../../storage/persistent/firestore/db.dart';
import '../../../storage/runtime/app_globals.dart';
import '../../common/screens/sections/components/molecules/atoms/sub_title_text_atom.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("LogInScreen");

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      actions: [
        AuthStateChangeAction<AuthState>(
          (context, state) {
            if (state is UserCreated) {
              createUser(FirebaseAuth.instance.currentUser);
            }
          },
        )
      ],
      providers: authProviders,
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: action == AuthAction.signIn
              ? const SubTitleTextHH('Welcome to Multi lang chat! Please sign in.')
              : const SubTitleTextHH('Welcome to Multi lang chat! Please register.'),
        );
      },
    );
  }

  void createUser(User? user) {
    _logger.v("createUser");
    if (user != null) {
      var displayName = user.displayName;
      if (displayName == null && user.email != null) {
        displayName = user.email?.split("@").first ?? "anonymous";
        user.updateDisplayName(displayName);
      }
      Db.users.doc(user.uid).set(AppUser(
            email: user.email,
            displayName: displayName,
            photoUrl: user.photoURL,
          ));
    }
  }
}
