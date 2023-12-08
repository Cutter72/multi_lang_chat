import 'package:flutter/material.dart';

import '../../../../model/actives/app_logger.dart';
import '../../../../model/passives/dtos/chat_room_data.dart';
import '../contacts_search_screen/contacts_search_screen.dart';
import '../developer_screen.dart';
import 'sections/input_section.dart';
import 'sections/msgs_section.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("ChatRoomScreen");

class ChatRoomScreen extends StatelessWidget {
  static const routeName = '/chat_room';
  final messageEditorController = TextEditingController();

  ChatRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatRoomData = ModalRoute.of(context)?.settings.arguments as ChatRoomData;
    return Scaffold(
      appBar: AppBar(
        title: Text("${chatRoomData.contactAppUser.displayName}"),
        actions: [
          IconButton(
            onPressed: () => _goToContactsSearchScreen(context),
            icon: const Icon(Icons.person_search, color: Colors.deepPurpleAccent),
          ),
          IconButton(
            onPressed: () => _goToDeveloperScreen(context),
            icon: const Icon(Icons.developer_board, color: Colors.deepPurpleAccent),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MsgsSection(chatRoom: chatRoomData.chatRoom),
          ),
          InputSection(
            messageEditorController: messageEditorController,
            chatRoom: chatRoomData.chatRoom,
          )
        ],
      ),
    );
  }

  void _goToContactsSearchScreen(BuildContext context) {
    _logger.v("_goToContactsSearchScreen");
    Navigator.pushNamed(context, ContactsSearchScreen.routeName);
  }

  void _goToDeveloperScreen(BuildContext context) {
    _logger.v("_goToDeveloperScreen");
    Navigator.pushNamed(context, DeveloperScreen.routeName);
  }
}
