import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/atoms/content_text.dart';
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
    const double avatarSize = 48;
    return Card(
      child: ListTile(
        leading: user.photoURL != null
            ? Image.network(
                user.photoURL!,
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
        title: TitleTextHHH(user.displayName!),
        subtitle: SubTitleTextHHH(user.email!),
        trailing: const Icon(
          Icons.add,
        ),
      ),
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
          ContentTextHHH("Photo URL broken")
        ],
      ),
    );
  }
}
