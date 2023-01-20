import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../firestore/contacts.dart';
import '../firestore/db.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactsProvider with ChangeNotifier {
  Contacts? _contacts;

  Contacts get contacts => _contacts == null ? Contacts(accepted: [], rejected: [], pending: []) : _contacts!;

  ContactsProvider();

  Future<Contacts> fetchContacts() async {
    if (_contacts == null) {
      return await Db.contacts.doc(Db.loggedFirebaseUser.uid).get().then((snapshot) {
        if (snapshot.data() == null) {
          return contacts;
        } else {
          _contacts = snapshot.data();
          return contacts;
        }
      }).onError((error, stackTrace) => contacts);
    } else {
      return contacts;
    }
  }
}
