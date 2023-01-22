import 'package:flutter/material.dart';

import '../../../../../../../model/firestore/app_user/app_user.dart';
import '../../../../../../../model/providers/contacts_provider.dart';

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
      onPressed: () => openChat(widget.user),
      icon: const Icon(
        Icons.chat,
        color: Colors.green,
      ),
    );
  }

  openChat(AppUser user) {
    // todo open chat_room_screen([participants])
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(user.toString()),
    ));
  }
}
