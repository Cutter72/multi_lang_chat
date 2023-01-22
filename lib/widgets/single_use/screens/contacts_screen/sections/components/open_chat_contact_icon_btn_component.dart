import 'package:flutter/material.dart';

import '../../../../../../model/passives/daos/app_user/app_user.dart';
import '../../../../../../storage/persistent/firestore/providers/contacts_provider.dart';
import '../../../chat_room_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class OpenChatContactIconBtn extends StatefulWidget {
  final AppUser user;

  const OpenChatContactIconBtn(this.user, {Key? key}) : super(key: key);

  @override
  State<OpenChatContactIconBtn> createState() => _OpenChatContactIconBtnState();
}

class _OpenChatContactIconBtnState extends State<OpenChatContactIconBtn> {
  bool isUserAlreadyInContacts = false;

  @override
  Widget build(BuildContext context) {
    isUserAlreadyInContacts = ContactsProvider.contacts.accepted.containsValue(widget.user);
    return IconButton(
      onPressed: () => goToChatRoom(widget.user),
      icon: const Icon(
        Icons.chat,
        color: Colors.green,
      ),
    );
  }

  goToChatRoom(AppUser user) {
    Navigator.pushNamed(context, ChatRoomScreen.routeName);
  }
}
