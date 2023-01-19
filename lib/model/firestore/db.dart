import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  static CollectionReference<Map<String, dynamic>> get users => instance.collection(_usersCollectionPath);

  static CollectionReference<Map<String, dynamic>> get contacts => instance.collection(_contactsCollectionPath);

  static CollectionReference<Map<String, dynamic>> get chatRooms => instance.collection(_chatRoomsCollectionPath);
}
