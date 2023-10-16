import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../model/actives/app_logger.dart';
import '../../../../../model/passives/daos/chat_room/chat_room.dart';
import '../../../../../model/passives/daos/chat_room_msg/chat_room_msg.dart';
import '../../../../../storage/persistent/firestore/db.dart';
import '../../../../../storage/runtime/app_globals.dart';
import '../../../../common/screens/sections/components/molecules/atoms/content_text_atom.dart';
import '../../../../common/screens/sections/components/molecules/atoms/waiting_indicator_atom.dart';
import 'msg_bubble.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("MsgsSection");

class MsgsSection extends StatelessWidget {
  const MsgsSection({
    Key? key,
    required this.chatRoom,
  }) : super(key: key);

  final ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<ChatRoomMsg>>(
        stream: Db.chatRoomMsgs(chatRoom.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: WaitingIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: prepareMsgs(snapshot.data?.docs),
                ),
              );
            } else {
              return const Center(
                child: ContentTextH("No messages"),
              );
            }
          }
        });
  }

  List<Widget> prepareMsgs(List<QueryDocumentSnapshot<ChatRoomMsg>>? msgs) {
    _logger.v("prepareMsgs");
    msgs?.sort((a, b) => a.data().timeSentMillis - b.data().timeSentMillis);
    return [
      ...?msgs?.map((msg) {
        if (msg.data().roleFor[lauUid] == "owner") {
          return MsgBubble(
            content: msg.data().content,
            timeSent: DateTime.fromMillisecondsSinceEpoch(msg.data().timeSentMillis),
            color: Colors.amberAccent,
            alignment: Alignment.centerRight,
          );
        } else {
          return MsgBubble(
            content: msg.data().content,
            timeSent: DateTime.fromMillisecondsSinceEpoch(msg.data().timeSentMillis),
            color: Colors.green,
            alignment: Alignment.centerLeft,
          );
        }
      }).toList(),
    ];
  }
}
