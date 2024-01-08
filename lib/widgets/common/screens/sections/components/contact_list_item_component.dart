import 'package:flutter/material.dart';

import '../../../../../model/passives/daos/app_user/app_user.dart';
import 'molecules/atoms/sub_title_text_atom.dart';
import 'molecules/atoms/title_text_atom.dart';
import 'molecules/avatar_molecule.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactListItem extends StatelessWidget {
  final AppUser user;
  final Widget trailingBtn;

  const ContactListItem({
    Key? key,
    required this.user,
    required this.trailingBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 48;
    return Card(
      child: ListTile(
        leading: Avatar(photoUrl: user.photoUrl, avatarSize: avatarSize),
        title: TitleTextHHH(user.displayName!),
        subtitle: SubTitleTextHHH(user.email!),
        trailing: trailingBtn,
      ),
    );
  }
}
