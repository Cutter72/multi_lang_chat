import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_lang_chat/model/providers/contacts_provider.dart';
import 'package:multi_lang_chat/widgets/atoms/sub_title_text.dart';
import 'package:multi_lang_chat/widgets/atoms/title_text.dart';

import '../../../model/firestore/app_user/app_user.dart';
import '../../../model/firestore/db.dart';
import 'photo_url_broken.dart';

class ContactsSearchResultListItem extends StatelessWidget {
  final AppUser user;

  const ContactsSearchResultListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 48;
    return Card(
      child: ListTile(
        leading: _ContactListItemAvatar(photoUrl: user.photoURL, avatarSize: avatarSize),
        title: TitleTextHHH(user.displayName!),
        subtitle: SubTitleTextHHH(user.email!),
        trailing: _AddRemoveContactIconBtn(user),
      ),
    );
  }
}

class _ContactListItemAvatar extends StatelessWidget {
  const _ContactListItemAvatar({
    Key? key,
    required this.photoUrl,
    required this.avatarSize,
  }) : super(key: key);

  final String? photoUrl;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return photoUrl != null
        ? _ImageAvatar(photoUrl: photoUrl, avatarSize: avatarSize)
        : _DefaultAvatar(avatarSize: avatarSize);
  }
}

class _ImageAvatar extends StatelessWidget {
  const _ImageAvatar({
    Key? key,
    required this.photoUrl,
    required this.avatarSize,
  }) : super(key: key);

  final String? photoUrl;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      photoUrl!,
      width: avatarSize,
      height: avatarSize,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
          frame == null ? const CircularProgressIndicator() : child,
      errorBuilder: (context, error, stackTrace) => _PhotoUrlBroken(avatarSize: avatarSize),
    );
  }
}

class _PhotoUrlBroken extends StatelessWidget {
  const _PhotoUrlBroken({
    Key? key,
    required this.avatarSize,
  }) : super(key: key);

  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return PhotoUrlBroken(avatarSize: avatarSize);
  }
}

class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar({
    Key? key,
    required this.avatarSize,
  }) : super(key: key);

  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.account_circle,
      size: avatarSize,
    );
  }
}

class _AddRemoveContactIconBtn extends StatefulWidget {
  final AppUser user;

  const _AddRemoveContactIconBtn(this.user, {Key? key}) : super(key: key);

  @override
  State<_AddRemoveContactIconBtn> createState() => _AddRemoveContactIconBtnState();
}

class _AddRemoveContactIconBtnState extends State<_AddRemoveContactIconBtn> {
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
