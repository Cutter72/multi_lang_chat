import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../model/firestore/app_user/app_user.dart';
import '../../../../../model/firestore/db.dart';
import '../../../../../model/providers/contacts_provider.dart';
import '../../../../atoms/sub_title_text.dart';
import '../../../../atoms/title_text.dart';
import 'contact_list_item_avatar.dart';

class ContactsListItem extends StatelessWidget {
  final AppUser user;

  const ContactsListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 48;
    return Card(
      child: ListTile(
        leading: ContactListItemAvatar(photoUrl: user.photoURL, avatarSize: avatarSize),
        title: TitleTextHHH(user.displayName!),
        subtitle: SubTitleTextHHH(user.email!),
        trailing: AddRemoveContactIconBtn(user),
      ),
    );
  }
}

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
    Db.contacts.doc(Db.luUid).set(ContactsProvider.contacts, SetOptions(merge: true)).onError((error, stackTrace) {
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
        .doc(Db.luUid)
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
