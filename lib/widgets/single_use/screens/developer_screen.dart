import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../../../model/actives/app_logger.dart';
import '../../../model/passives/daos/chat_room/chat_room.dart';
import '../../../storage/persistent/firestore/db.dart';
import '../../../storage/runtime/app_globals.dart';
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
              child: const Text("Log out"),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
            ElevatedButton(
              child: const Text("Go to user settings"),
              onPressed: () {
                Navigator.pushNamed(context, UserSettingsScreen.routeName);
              },
            ),
            ElevatedButton(
              child: const Text("Delete FirebaseFirestore clearPersistence"),
              onPressed: () {
                Db.instance.clearPersistence();
              },
            ),
            ElevatedButton(
              child: const Text("Create"),
              onPressed: () {
                Db.chatRooms.doc(lauUid).set(ChatRoom(uid: "uid", roleFor: {lauUid: "owner"})).then((value) {
                  // Db.chatRooms.doc("${laUid}/msgs/${laUid}").set({"data": "Create msg work!wer"});
                  return null;
                });
              },
            ),
            ElevatedButton(
              child: const Text("Read"),
              onPressed: () {
                Db.chatRooms.doc("$lauUid/msgs/$lauUid").get().then((snap) => print("Read msg work! data = $snap"));
              },
            ),
            ElevatedButton(
              child: const Text("Update"),
              onPressed: () {
                Db.chatRooms.doc("$lauUid/msgs/$lauUid").update({"data": "Update msg work!"});
                // Db.contacts
                //     .where(FieldPath.fromString("pending.${laUid}"),
                //         arrayContains: loggedAppUser.toMap())
                //     .then((value) => print(value));
              },
            ),
            ElevatedButton(
              child: const Text("Delete"),
              onPressed: () {
                Db.chatRooms.doc("$lauUid/msgs/$lauUid").delete().then((_) => print("Delete msg work!"));
              },
            ),
            ElevatedButton(
              child: const Text("Find contact of me"),
              onPressed: () {
                Db.contacts
                    .where(FieldPath.fromString("accepted.$lauUid"), isNotEqualTo: null)
                    .where(FieldPath.fromString("rejected.$lauUid"), isNotEqualTo: null)
                    .where(FieldPath.fromString("pending.$lauUid"), isNotEqualTo: null)
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
                AppLogger.get(runtimeType.toString()).v("Verbose message");
              },
            ),
            ElevatedButton(
              child: const Text("Log debug"),
              onPressed: () {
                AppLogger.get(runtimeType.toString()).d("Debug message");
              },
            ),
            ElevatedButton(
              child: const Text("Log info"),
              onPressed: () {
                AppLogger.get(runtimeType.toString()).i("Info message");
              },
            ),
            ElevatedButton(
              child: const Text("Log warn"),
              onPressed: () {
                AppLogger.get(runtimeType.toString()).w("Warn message");
              },
            ),
            ElevatedButton(
              child: const Text("Log error"),
              onPressed: () {
                AppLogger.get(runtimeType.toString()).e("Error message");
              },
            ),
            ElevatedButton(
              child: const Text("Log WTF"),
              onPressed: () {
                AppLogger.get(runtimeType.toString()).wtf("WTF message");
              },
            ),
          ],
        ),
      ),
    );
  }
}
