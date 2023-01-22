import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/screens/developer_screen.dart';

import 'auth_gate_screen.dart';
import 'contacts_screen/contacts_screen.dart';
import 'contacts_search_screen/contacts_search_screen.dart';
import 'user_settings_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AppRootScreen extends StatelessWidget {
  const AppRootScreen({super.key});

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
        ContactsSearchScreen.routeName: (context) {
          return const ContactsSearchScreen();
        },
        UserSettingsScreen.routeName: (context) {
          return const UserSettingsScreen();
        },
        DeveloperScreen.routeName: (context) {
          return const DeveloperScreen();
        },
      },
    );
  }
}
