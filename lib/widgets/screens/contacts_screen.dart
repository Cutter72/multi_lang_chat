import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/firestore/db.dart';
import '../../model/providers/contacts_provider.dart';
import 'contacts_search/contacts_search_screen.dart';
import 'user_settings_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactsScreen extends StatelessWidget {
  static const routeName = '/contacts';

  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _initContacts();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(onPressed: () => _goToContactsSearchScreen(context), icon: const Icon(Icons.person_search)),
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
              ElevatedButton(
                child: Text("Create"),
                onPressed: () {
                  Db.chatRooms.doc("${Db.luUid}").set({
                    "roleFor": {Db.luUid: "writerwer"}
                  }).then((value) {
                    Db.chatRooms.doc("${Db.luUid}/msgs/${Db.luUid}").set({"data": "Create msg work!wer"});
                    return null;
                  });
                },
              ),
              ElevatedButton(
                child: Text("Read"),
                onPressed: () {
                  Db.chatRooms
                      .doc("${Db.luUid}/msgs/${Db.luUid}")
                      .get()
                      .then((snap) => print("Read msg work! data = $snap"));
                },
              ),
              ElevatedButton(
                child: Text("Update"),
                onPressed: () {
                  Db.chatRooms.doc("${Db.luUid}/msgs/${Db.luUid}").update({"data": "Update msg work!"});
                  // Db.contacts
                  //     .where(FieldPath.fromString("pending.${Db.luUid}"),
                  //         arrayContains: loggedAppUser.toMap())
                  //     .then((value) => print(value));
                },
              ),
              ElevatedButton(
                child: Text("Delete"),
                onPressed: () {
                  Db.chatRooms.doc("${Db.luUid}/msgs/${Db.luUid}").delete()
                      .then((_) => print("Delete msg work!"));
                },
              ),
              ElevatedButton(
                child: const Text("Find contact of me"),
                onPressed: () {
                  Db.contacts
                      .where(FieldPath.fromString("accepted.${Db.luUid}"), isNotEqualTo: null)
                      .where(FieldPath.fromString("rejected.${Db.luUid}"), isNotEqualTo: null)
                  .where(FieldPath.fromString("pending.${Db.luUid}"), isNotEqualTo: null)
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  print("MY.LOG.contacts: ${element.data()}");
                });
              });
            },
          ),
        ],
      )),
    );
  }

  void _goToContactsSearchScreen(BuildContext context) {
    Navigator.pushNamed(context, ContactsSearchScreen.routeName);
  }

  void _initContacts() {
    if (!_isContactsInitialized) {
      ContactsProvider.fetchContacts().then((contacts) {
        _isContactsInitialized = true;
      }).onError((error, stackTrace) {
        print(error);
      });
    }
  }
}

// Outside of class to have a const constructor
bool _isContactsInitialized = false;
