import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../../../model/actives/app_logger.dart';
import '../../../model/passives/daos/chat_room/chat_room.dart';
import '../../../storage/persistent/firestore/db.dart';
import 'user_settings_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class DeveloperScreen extends StatelessWidget {
  static const routeName = '/developer';

  const DeveloperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              child: Text("Delete FirebaseFirestore clearPersistence"),
              onPressed: () {
                Db.instance.clearPersistence();
              },
            ),
            ElevatedButton(
              child: Text("Create"),
              onPressed: () {
                Db.chatRooms.doc("${Db.luUid}").set(ChatRoom(uid: "uid", roleFor: {Db.luUid: "owner"})).then((value) {
                  // Db.chatRooms.doc("${Db.luUid}/msgs/${Db.luUid}").set({"data": "Create msg work!wer"});
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
                Db.chatRooms.doc("${Db.luUid}/msgs/${Db.luUid}").delete().then((_) => print("Delete msg work!"));
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
            ElevatedButton(
              child: const Text("Crashlytics test crash"),
              onPressed: () {
                throw Exception("Test crash MSG");
              },
            ),
            ElevatedButton(
              child: const Text("Crashlytics test Future crash"),
              onPressed: () async {
                throw Exception("Test Future crash MSG");
              },
            ),
            ElevatedButton(
              child: const Text("Crashlytics log MSG"),
              onPressed: () {
                FirebaseCrashlytics.instance.log("Crashlytics log MSG");
              },
            ),
            ElevatedButton(
              child: const Text("Log verbose"),
              onPressed: () {
                AppLogger(runtimeType.toString()).v("Verbose message");
              },
            ),
            ElevatedButton(
              child: const Text("Log debug"),
              onPressed: () {
                AppLogger(runtimeType.toString()).d("Debug message");
              },
            ),
            ElevatedButton(
              child: const Text("Log info"),
              onPressed: () {
                AppLogger(runtimeType.toString()).i("Info message");
              },
            ),
            ElevatedButton(
              child: const Text("Log warn"),
              onPressed: () {
                AppLogger(runtimeType.toString()).w("Warn message");
              },
            ),
            ElevatedButton(
              child: const Text("Log error"),
              onPressed: () {
                AppLogger(runtimeType.toString()).e("Error message");
              },
            ),
            ElevatedButton(
              child: const Text("Log WTF"),
              onPressed: () {
                AppLogger(runtimeType.toString()).wtf("WTF message");
              },
            ),
          ],
        ),
      ),
    );
  }
}
