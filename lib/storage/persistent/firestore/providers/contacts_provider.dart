import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../model/passives/daos/contacts/contacts.dart';
import '../db.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactsProvider with ChangeNotifier {
  static Contacts? _contacts;

  static Contacts get contacts => _contacts == null ? Contacts(accepted: {}, rejected: {}, pending: {}) : _contacts!;

  static Future<Contacts> fetchContacts() async {
    if (_contacts == null) {
      return await Db.contacts.doc(Db.luUid).get().then((snapshot) {
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