import 'package:flutter/material.dart';

import '../../../../model/passives/daos/chat_room/chat_room.dart';
import '../contacts_search_screen/contacts_search_screen.dart';
import '../developer_screen.dart';
import 'sections/input_section.dart';
import 'sections/msgs_section.dart';

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
          Expanded(
            child: MsgsSection(chatRoom: chatRoom),
          ),
          InputSection(
            messageEditorController: messageEditorController,
            chatRoom: chatRoom,
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
}
