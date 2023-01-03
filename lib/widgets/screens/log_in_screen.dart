import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../../model/app_globals.dart';
import '../../model/firestore/db_collections.dart';
import '../atoms/sub_title_text.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

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
              ? const SubTitleTextHH('Welcome to Multi lang chat, please sign in!')
              : const SubTitleTextHH('Welcome to Multi lang chat, please sign up!'),
        );
      },
    );
  }

  void createUser(User? user) {
    if (user != null) {
      var displayName = user.displayName;
      if (displayName == null && user.email != null) {
        displayName = user.email?.split("@").first ?? "anonymous";
        user.updateDisplayName(displayName);
      }
      db.collection(users).doc(user.uid).set({
        'email': user.email,
        'displayName': displayName,
        'photoURL': user.photoURL,
      });
    }
  }
}
