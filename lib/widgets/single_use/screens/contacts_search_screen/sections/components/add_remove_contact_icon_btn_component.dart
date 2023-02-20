import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../model/passives/daos/app_user/app_user.dart';
import '../../../../../../storage/persistent/firestore/db.dart';
import '../../../../../../storage/persistent/firestore/providers/contacts_provider.dart';
import '../../../../../../storage/runtime/app_globals.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AddRemoveContactIconBtn extends StatefulWidget {
  final AppUser user;

  const AddRemoveContactIconBtn(this.user, {Key? key}) : super(key: key);

  @override
  State<AddRemoveContactIconBtn> createState() => _AddRemoveContactIconBtnState();
}

class _AddRemoveContactIconBtnState extends State<AddRemoveContactIconBtn> {
  bool isUserAlreadyInContacts = false;

  @override
  Widget build(BuildContext context) {
    isUserAlreadyInContacts = ContactsProvider.contacts.accepted.containsValue(widget.user);
    return IconButton(
      onPressed: () => _addRemoveContact(isUserAlreadyInContacts).call(widget.user),
      icon: _addRemoveContactIcon(isUserAlreadyInContacts),
    );
  }

  Function(AppUser user) _addRemoveContact(bool isUserAlreadyInContacts) {
    return isUserAlreadyInContacts ? _removeContact : _addContact;
  }

  void _removeContact(AppUser user) {
    _removeContactFromMemory(user);
    _removeContactFromDb(user);
  }

  void _removeContactFromMemory(AppUser user) {
    ContactsProvider.contacts.accepted.remove(user.uid);
    _changeState(isUserAlreadyInContacts: false);
  }

  void _removeContactFromDb(AppUser user) {
    Db.contacts.doc(lauUid).set(ContactsProvider.contacts, SetOptions(merge: true)).onError((error, stackTrace) {
      _addContactToMemory(user);
    });
  }

  void _addContact(AppUser user) {
    _addContactToMemory(user);
    _addContactToDb(user);
  }

  void _addContactToMemory(AppUser user) {
    ContactsProvider.contacts.accepted[user.uid] = user;
    _changeState(isUserAlreadyInContacts: true);
  }

  void _addContactToDb(AppUser user) {
    Db.contacts
        .doc(lauUid)
        .set(ContactsProvider.contacts, SetOptions(merge: true))
        .onError((error, stackTrace) => _removeContactFromMemory(user));
  }

  void _changeState({required bool isUserAlreadyInContacts}) {
    setState(() {
      this.isUserAlreadyInContacts = isUserAlreadyInContacts;
    });
  }

  StatelessWidget _addRemoveContactIcon(bool isUserAlreadyInContacts) {
    return isUserAlreadyInContacts ? const _RemoveContactIcon() : const _AddContactIcon();
  }
}

class _RemoveContactIcon extends StatelessWidget {
  const _RemoveContactIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.person_remove,
      color: Colors.red,
    );
  }
}

class _AddContactIcon extends StatelessWidget {
  const _AddContactIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.person_add);
  }
}
