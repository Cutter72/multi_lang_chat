import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/atoms/sub_title_text.dart';

import '../../model/app_globals.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
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
}
