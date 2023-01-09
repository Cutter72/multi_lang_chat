import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class Db {
  static const _usersCollectionPath = "users";
  static const _contactsCollectionPath = "contacts";

  static late FirebaseFirestore db;
  static late User loggedFirebaseUser;

  static CollectionReference<Map<String, dynamic>> get users => db.collection(_usersCollectionPath);

  static CollectionReference<Map<String, dynamic>> get contacts => db.collection(_contactsCollectionPath);
}
