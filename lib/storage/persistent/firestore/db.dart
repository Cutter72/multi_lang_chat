import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multi_lang_chat/storage/runtime/app_globals.dart';

import '../../../model/actives/app_logger.dart';
import '../../../model/passives/daos/app_user/app_user.dart';
import '../../../model/passives/daos/chat_room/chat_room.dart';
import '../../../model/passives/daos/chat_room_msg/chat_room_msg.dart';
import '../../../model/passives/daos/contacts/contacts.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("Db");

class Db {
  static const _root = "root/dev";
  static const _usersCollectionPath = "$_root/users";
  static const _contactsCollectionPath = "$_root/contacts";
  static const _chatRoomsCollectionPath = "$_root/chat_rooms";
  static const _chatRoomsMsgsCollectionName = "msgs";

  static late FirebaseFirestore instance;
  static late User loggedFirebaseUser;

  static CollectionReference<AppUser> get users {
    _logger.v("get users");
    return instance.collection(_usersCollectionPath).withConverter(
          fromFirestore: (snapshot, options) => AppUserMapper.fromMap(snapshot.data() ?? {}),
          toFirestore: (appUser, options) => appUser.toMap(),
        );
  }

  static CollectionReference<Contacts> get contacts {
    _logger.v("get contacts");
    return instance.collection(_contactsCollectionPath).withConverter(
          fromFirestore: (snapshot, options) => ContactsMapper.fromMap(snapshot.data() ?? {}),
          toFirestore: (contacts, options) => contacts.toMap(),
        );
  }

  static CollectionReference<ChatRoom> get chatRooms {
    _logger.v("get chatRooms");
    return instance.collection(_chatRoomsCollectionPath).withConverter(
          fromFirestore: (snapshot, options) => ChatRoomMapper.fromMap(snapshot.data() ?? {}),
          toFirestore: (chatRoom, options) => chatRoom.toMap(),
        );
  }

  static CollectionReference<ChatRoomMsg> chatRoomMsgs(String chatRoomId) {
    _logger.d("chatRoomMsgs: $chatRoomId");
    return instance.collection("$_chatRoomsCollectionPath/$chatRoomId/$_chatRoomsMsgsCollectionName").withConverter(
          fromFirestore: (snapshot, options) => ChatRoomMsgMapper.fromMap(snapshot.data() ?? {}),
          toFirestore: (chatRoomMsg, options) => chatRoomMsg.toMap(),
        );
  }

  static void updateAppUserData(AppUser loggedAppUser) {
    _logger.d("updateAppUserData: ${loggedAppUser.uid}");
    instance.runTransaction((transaction) async {
      transaction.set(users.doc(lauUid), loggedAppUser);
      await contacts
          .where(FieldPath.fromString("accepted.$lauUid"), isNotEqualTo: null)
          .where(FieldPath.fromString("rejected.$lauUid"), isNotEqualTo: null)
          .where(FieldPath.fromString("pending.$lauUid"), isNotEqualTo: null)
          .get()
          .then((queryResult) {
        for (var docSnapshot in queryResult.docs) {
          _updateAppUserDataInDocument(transaction, docSnapshot, loggedAppUser);
        }
      });
    });
  }

  static void _updateAppUserDataInDocument(
      Transaction transaction, QueryDocumentSnapshot<Contacts> docSnapshot, AppUser loggedAppUser) {
    _logger.d("_updateAppUserDataInDocument: ${docSnapshot.id}");
    transaction.update(docSnapshot.reference, docSnapshot.data().update(loggedAppUser).toMap());
  }
}
