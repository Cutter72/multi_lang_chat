import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/passives/daos/app_user/app_user.dart';
import '../../../model/passives/daos/contacts/contacts.dart';

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

  // luUid -> logged user UID
  static get luUid => loggedFirebaseUser.uid;

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
      transaction.set(users.doc(Db.luUid), loggedAppUser);
      await contacts
          .where(FieldPath.fromString("accepted.${Db.luUid}"), isNotEqualTo: null)
          .where(FieldPath.fromString("rejected.${Db.luUid}"), isNotEqualTo: null)
          .where(FieldPath.fromString("pending.${Db.luUid}"), isNotEqualTo: null)
          .get()
          .then((queryResult) {
        for (var docSnapshot in queryResult.docs) {
          transaction.update(docSnapshot.reference, docSnapshot.data().update(loggedAppUser).toMap());
        }
      });
    });
  }
}
