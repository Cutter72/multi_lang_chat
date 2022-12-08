import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'contacts_search_screen.dart';
import 'user_settings_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactsScreen extends StatelessWidget {
  static const routeName = '/contacts';

  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(onPressed: () => _goToContactsSearchScreen(context), icon: const Icon(Icons.add)),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            child: Text("Log out"),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          ElevatedButton(
            child: Text("Go to user settings"),
            onPressed: () {
              Navigator.pushNamed(context, UserSettingsScreen.routeName);
            },
          ),
        ],
      )),
    );
  }

  void _goToContactsSearchScreen(BuildContext context) {
    Navigator.pushNamed(context, ContactsSearchScreen.routeName);
  }
}
