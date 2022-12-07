import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/screens/contacts_screen.dart';

import 'log_in_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AuthGateScreen extends StatelessWidget {
  static const routeName = "/auth-gate";

  const AuthGateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const ContactsScreen();
        }
        return const LogInScreen();
      },
    );
  }
}
