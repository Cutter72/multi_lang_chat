import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../../../storage/runtime/app_globals.dart';
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
        titleSpacing: -12,
        title: const Text("User settings"),
      ),
      avatarPlaceholderColor: Colors.purple,
      providers: authProviders,
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, AuthGateScreen.routeName);
        }),
        AccountDeletedAction((context, user) {
          deleteUserData(user);
        }),
        DisplayNameChangedAction((context, oldName, newName) {
          updateUserDisplayName(newName);
        }),
      ],
    );
  }

  void updateUserDisplayName(String context) {
    // todo
  }

  void deleteUserData(User user) {
    // todo
  }
}
