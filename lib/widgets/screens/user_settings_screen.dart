import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'auth_gate_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class UserSettingsScreen extends StatelessWidget {
  static const routeName = "/user";

  const UserSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        title: const SelectionContainer.disabled(child: Text("User settings")),
      ),
      avatarPlaceholderColor: Colors.orange,
      providers: authProviders,
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, AuthGateScreen.routeName);
        }),
      ],
    );
  }
}
