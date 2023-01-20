import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multi_lang_chat/model/firestore/app_user/app_user.dart';

import 'contacts.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class Db {
  static const _root = "root/dev";
  static const _usersCollectionPath = "$_root/users";
  static const _contactsCollectionPath = "$_root/contacts";
  static const _chatRoomsCollectionPath = "$_root/chat_rooms";

  static late FirebaseFirestore instance;
  static late User loggedFirebaseUser;

  static CollectionReference<AppUser> get users => instance.collection(_usersCollectionPath).withConverter(
        fromFirestore: (snapshot, options) => AppUserMapper.fromMap(snapshot.data() ?? {}),
        toFirestore: (appUser, options) => appUser.toMap(),
      );

  static CollectionReference<Contacts> get contacts => instance.collection(_contactsCollectionPath).withConverter(
        fromFirestore: (snapshot, options) => ContactsMapper.fromMap(snapshot.data() ?? {}),
        toFirestore: (contacts, options) => contacts.toMap(),
      );

  static CollectionReference<Map<String, dynamic>> get chatRooms => instance.collection(_chatRoomsCollectionPath);

  static void updateAppUserData(AppUser loggedAppUser) {
    instance.runTransaction((transaction) async {
      transaction.set(users.doc(Db.loggedFirebaseUser.uid), loggedAppUser);
      await contacts
          .where(FieldPath.fromString("accepted.${Db.loggedFirebaseUser.uid}"), isNotEqualTo: null)
          .where(FieldPath.fromString("rejected.${Db.loggedFirebaseUser.uid}"), isNotEqualTo: null)
          .where(FieldPath.fromString("pending.${Db.loggedFirebaseUser.uid}"), isNotEqualTo: null)
          .get()
          .then((queryResult) {
        for (var docSnapshot in queryResult.docs) {
          transaction.update(docSnapshot.reference, docSnapshot.data().update(loggedAppUser).toMap());
        }
      });
    });
  }
}
