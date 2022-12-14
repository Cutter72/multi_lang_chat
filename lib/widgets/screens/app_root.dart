import 'package:flutter/material.dart';

import 'auth_gate_screen.dart';
import 'contacts_screen.dart';
import 'user_settings_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Multi lang chat",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AuthGateScreen(),
      initialRoute: AuthGateScreen.routeName,
      routes: {
        AuthGateScreen.routeName: (context) {
          return const AuthGateScreen();
        },
        ContactsScreen.routeName: (context) {
          return const ContactsScreen();
        },
        UserSettingsScreen.routeName: (context) {
          return const UserSettingsScreen();
        },
      },
    );
  }
}
