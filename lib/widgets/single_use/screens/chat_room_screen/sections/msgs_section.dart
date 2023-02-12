import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../model/passives/daos/chat_room/chat_room.dart';
import '../../../../../model/passives/daos/chat_room_msg/chat_room_msg.dart';
import '../../../../../storage/persistent/firestore/db.dart';
import '../../../../numerous_use/screens/sections/components/molecules/atoms/content_text_atom.dart';
import '../../../../numerous_use/screens/sections/components/molecules/atoms/waiting_indicator_atom.dart';

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
              var msgs = snapshot.data?.docs;
              msgs?.sort((a, b) => a.data().timeSentMillis - b.data().timeSentMillis);
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [...?msgs?.map((e) => ContentTextH("Message: ${e.data().content}")).toList()],
              );
            } else {
              return const Center(
                child: ContentTextH("No messages"),
              );
            }
          }
        });
  }
}
