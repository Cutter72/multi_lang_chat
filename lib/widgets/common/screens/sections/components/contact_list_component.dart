import 'package:flutter/material.dart';

import '../../../../../model/actives/app_logger.dart';
import '../../../../../model/passives/daos/app_user/app_user.dart';
import 'contact_list_item_component.dart';
import 'molecules/atoms/content_text_atom.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("ContactList");

class ContactList extends StatelessWidget {
  final List<AppUser> users;
  final Widget Function(AppUser) trailingBtn;

  const ContactList({required this.users, required this.trailingBtn, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (users.isEmpty) {
          return const _NoUsersFound();
        } else {
          return ContactListItem(
            user: users[index],
            trailingBtn: trailingBtn(users[index]),
          );
        }
      },
      // minimum 1 to show No items text if null or empty
      itemCount: users.isEmpty ? 1 : users.length,
    );
  }
}

class _NoUsersFound extends StatelessWidget {
  const _NoUsersFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: ContentTextHHH("No contacts."),
    );
  }
}
