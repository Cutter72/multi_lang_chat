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
    required TextEditingController messageEditorController,
    required ChatRoom chatRoom,
  })  : _chatRoom = chatRoom,
        _messageEditorController = messageEditorController,
        super(key: key);

  final TextEditingController _messageEditorController;
  final ChatRoom _chatRoom;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextInputField(
          "Type a message...",
          _messageEditorController,
        )),
        IconButton(
          onPressed: () => sendMessage(),
          icon: const Icon(Icons.send, color: Colors.deepPurpleAccent),
        ),
      ],
    );
  }

  void sendMessage() {
    _logger.v("sendMessage");
    var msg = ChatRoomMsg.create(_messageEditorController.value.text, lauUid);
    _logger.i("Msg: $msg");
    Db.chatRoomMsgs(_chatRoom.uid).doc().set(msg);
    _messageEditorController.clear();
  }
}
