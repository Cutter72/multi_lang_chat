import 'package:flutter/material.dart';
import 'package:multi_lang_chat/model/passives/daos/chat_room/chat_room.dart';
import 'package:multi_lang_chat/model/passives/daos/chat_room_msg/chat_room_msg.dart';

import '../../../storage/persistent/firestore/db.dart';
import '../../numerous_use/screens/sections/components/molecules/atoms/text_input_field_atom.dart';
import '../../numerous_use/screens/sections/components/molecules/atoms/waiting_indicator_atom.dart';
import 'contacts_search_screen/contacts_search_screen.dart';
import 'developer_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ChatRoomScreen extends StatelessWidget {
  static const routeName = '/chat_room';
  final messageEditorController = TextEditingController();

  ChatRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatRoom = ModalRoute.of(context)?.settings.arguments as ChatRoom;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat room"),
        actions: [
          IconButton(
            onPressed: () => _goToContactsSearchScreen(context),
            icon: const Icon(Icons.person_search),
          ),
          IconButton(
            onPressed: () => _goToDeveloperScreen(context),
            icon: const Icon(Icons.developer_board),
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
              child: Center(
                child: WaitingIndicator(),
              )),
          Row(
            children: [
              Expanded(child: TextInputField("Type a message...", messageEditorController)),
              IconButton(
                onPressed: () => sendMessage(messageEditorController.value.text, chatRoom),
                icon: const Icon(Icons.send),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _goToContactsSearchScreen(BuildContext context) {
    Navigator.pushNamed(context, ContactsSearchScreen.routeName);
  }

  void _goToDeveloperScreen(BuildContext context) {
    Navigator.pushNamed(context, DeveloperScreen.routeName);
  }

  void sendMessage(String message, ChatRoom chatRoom) {
    var msg = ChatRoomMsg.create(message, Db.luUid);
    print(msg);
    Db.chatRoomMsgs(chatRoom.uid).doc().set(msg);
  }
}
