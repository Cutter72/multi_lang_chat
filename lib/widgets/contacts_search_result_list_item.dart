import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/atoms/content_text.dart';
import 'package:multi_lang_chat/widgets/atoms/sub_title_text.dart';
import 'package:multi_lang_chat/widgets/atoms/title_text.dart';

import '../model/firestore/app_user/app_user.dart';
import '../model/firestore/contacts.dart';
import '../model/firestore/db.dart';

class ContactsSearchResultListItem extends StatefulWidget {
  final AppUser user;

  final Contacts contacts;

  const ContactsSearchResultListItem({
    Key? key,
    required this.user,
    required this.contacts,
  }) : super(key: key);

  @override
  State<ContactsSearchResultListItem> createState() => _ContactsSearchResultListItemState();
}

class _ContactsSearchResultListItemState extends State<ContactsSearchResultListItem> {
  @override
  Widget build(BuildContext context) {
    const double avatarSize = 48;
    return Card(
      child: ListTile(
        leading: widget.user.photoURL != null
            ? Image.network(
                widget.user.photoURL!,
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                    frame == null ? const CircularProgressIndicator() : child,
                errorBuilder: (context, error, stackTrace) => const _PhotoUrlBroken(avatarSize: avatarSize),
              )
            : const Icon(
                Icons.account_circle,
                size: avatarSize,
              ),
        title: TitleTextHHH(widget.user.displayName!),
        subtitle: SubTitleTextHHH(widget.user.email!),
        trailing: IconButton(
          onPressed: () =>
              widget.contacts.accepted.contains(widget.user) ? removeContact(widget.user) : addContact(widget.user),
          icon: widget.contacts.accepted.contains(widget.user)
              ? const Icon(
                  Icons.person_remove,
                  color: Colors.red,
                )
              : const Icon(Icons.person_add),
        ),
      ),
    );
  }

  void addContact(AppUser user) {
    setState(() {
      widget.contacts.accepted.add(user);
      Db.contacts.doc(Db.loggedFirebaseUser.uid).set(widget.contacts.toMap(), SetOptions(merge: true));
    });
  }

  void removeContact(AppUser user) {
    setState(() {
      widget.contacts.accepted.remove(user);
      Db.contacts.doc(Db.loggedFirebaseUser.uid).set(widget.contacts.toMap(), SetOptions(merge: true));
    });
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
    return SizedBox(
      height: avatarSize,
      width: avatarSize,
      child: Stack(
        children: const [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.error,
              size: 18,
              color: Colors.red,
            ),
          ),
          ContentTextHHH("Photo URL broken.")
        ],
      ),
    );
  }
}
