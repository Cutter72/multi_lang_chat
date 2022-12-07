import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/screens/user_settings_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactsScreen extends StatelessWidget {
  static const routeName = '/home';

  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SelectionContainer.disabled(child: Text("Contacts")),
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
}
