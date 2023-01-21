import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/screens/contacts_search_screen/result_section/result_component/contact_list_subcomponent/contact_list_item/image_avatar.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.photoUrl,
    required this.avatarSize,
  }) : super(key: key);

  final String? photoUrl;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return photoUrl != null
        ? ImageAvatar(photoUrl: photoUrl, avatarSize: avatarSize)
        : _DefaultAvatar(avatarSize: avatarSize);
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
