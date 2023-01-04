import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/atoms/sub_title_text.dart';
import 'package:multi_lang_chat/widgets/atoms/title_text.dart';

import '../model/firestore/app_user.dart';

class ContactsSearchResultListItem extends StatelessWidget {
  final AppUser user;

  const ContactsSearchResultListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: user.photoURL != null
            ? Image.network(
                user.photoURL!,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              )
            : const Icon(
                Icons.account_circle,
                size: 48,
              ),
        title: TitleTextHHH(user.displayName!),
        subtitle: SubTitleTextHHH(user.email!),
        trailing: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
