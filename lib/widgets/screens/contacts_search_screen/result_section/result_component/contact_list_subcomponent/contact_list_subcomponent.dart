import 'package:flutter/material.dart';

import '../../../../../../model/firestore/app_user/app_user.dart';
import '../../../../../atoms/content_text.dart';
import 'contact_list_item/contact_list_item.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactList extends StatelessWidget {
  final List<AppUser> users;
  final Widget Function(AppUser) trailingBtn;

  const ContactList(this.users, {Key? key, required this.trailingBtn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
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
      itemCount: itemCount(users),
    );
  }

  int? itemCount(List<AppUser> data) {
    // minimum 1 to show No items text if null or empty
    return data.isNotEmpty ? data.length : 1;
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
      child: ContentTextHHH("No users found."),
    );
  }
}
