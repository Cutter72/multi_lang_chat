import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/screens/contacts_search_screen/result_section/result_component/contact_list_subcomponent/contact_list_item/add_remove_contact_icon_btn.dart';

import '../../../../../../../model/firestore/app_user/app_user.dart';
import '../../../../../../atoms/sub_title_text.dart';
import '../../../../../../atoms/title_text.dart';
import 'avatar.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ContactListItem extends StatelessWidget {
  final AppUser user;

  const ContactListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 48;
    return Card(
      child: ListTile(
        leading: Avatar(photoUrl: user.photoURL, avatarSize: avatarSize),
        title: TitleTextHHH(user.displayName!),
        subtitle: SubTitleTextHHH(user.email!),
        trailing: AddRemoveContactIconBtn(user),
      ),
    );
  }
}
