import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../model/actives/app_logger.dart';
import '../../../../model/passives/daos/contacts/contacts.dart';
import '../../../runtime/app_globals.dart';
import '../db.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("ContactsProvider");

class ContactsProvider with ChangeNotifier {
  static Contacts? _contacts;

  static Contacts get contacts => _contacts == null
      ? Contacts(accepted: {}, rejected: {}, pending: {})
      : _contacts!;

  static Future<Contacts> fetchContacts() async {
    _logger.v("fetchContacts");
    return await Db.contacts.doc(lauUid).get().then((snapshot) {
      if (snapshot.data() == null) {
        return contacts;
      } else {
        _contacts = snapshot.data();
        return contacts;
      }
    }).onError((error, stackTrace) => contacts);
  }

  static void resetContacts() async {
    _logger.v("resetContacts");
    _contacts = null;
    fetchContacts();
  }
}
