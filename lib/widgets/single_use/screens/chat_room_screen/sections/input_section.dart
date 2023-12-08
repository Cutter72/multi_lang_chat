import 'package:flutter/material.dart';

import '../../../../../model/actives/app_logger.dart';
import '../../../../../model/passives/daos/chat_room/chat_room.dart';
import '../../../../../model/passives/daos/chat_room_msg/chat_room_msg.dart';
import '../../../../../storage/persistent/firestore/db.dart';
import '../../../../../storage/runtime/app_globals.dart';
import '../../../../common/screens/sections/components/molecules/atoms/text_input_field_atom.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("InputSection");

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
          icon: const Icon(Icons.send, color: Colors.deepPurpleAccent),
        ),
      ],
    );
  }

  void sendMessage(String message, ChatRoom chatRoom) {
    _logger.v("sendMessage");
    var msg = ChatRoomMsg.create(message, lauUid);
    _logger.i("Msg: $msg");
    Db.chatRoomMsgs(chatRoom.uid).doc().set(msg);
  }
}
