import 'package:flutter/material.dart';

import '../../../../../model/passives/daos/chat_room/chat_room.dart';
import '../../../../../model/passives/daos/chat_room_msg/chat_room_msg.dart';
import '../../../../../storage/persistent/firestore/db.dart';
import '../../../../../storage/runtime/app_globals.dart';
import '../../../../numerous_use/screens/sections/components/molecules/atoms/text_input_field_atom.dart';

class InputSection extends StatelessWidget {
  const InputSection({
    Key? key,
    required this.messageEditorController,
    required this.chatRoom,
  }) : super(key: key);

  final TextEditingController messageEditorController;
  final ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextInputField("Type a message...", messageEditorController)),
        IconButton(
          onPressed: () => sendMessage(messageEditorController.value.text, chatRoom),
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }

  void sendMessage(String message, ChatRoom chatRoom) {
    var msg = ChatRoomMsg.create(message, lauUid);
    print(msg);
    Db.chatRoomMsgs(chatRoom.uid).doc().set(msg);
  }
}
