import 'package:flutter/material.dart';

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
                onPressed: () => sendMessage(messageEditorController.value.text),
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

  void sendMessage(String message) {
    // TODO
  }
}
