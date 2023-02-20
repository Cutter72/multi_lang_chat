import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../model/passives/daos/app_user/app_user.dart';
import '../../../../../../model/passives/daos/chat_room/chat_room.dart';
import '../../../../../../storage/persistent/firestore/db.dart';
import '../../../../../../storage/runtime/app_globals.dart';
import '../../../chat_room_screen/chat_room_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => goToPrivateChatRoomWith(widget.user),
      icon: const Icon(
        Icons.chat,
        color: Colors.green,
      ),
    );
  }

  goToPrivateChatRoomWith(AppUser targetUser) async {
    ChatRoom? existingChatRoom = await resolveExistingChatRoom(lauUid, targetUser.uid);
    if (existingChatRoom != null) {
      goTo(existingChatRoom);
    } else {
      var newChatRoom = ChatRoom.forPrivateConversation(Db.chatRooms.doc().id, lauUid, targetUser.uid!);
      Db.chatRooms.doc(newChatRoom.uid).set(newChatRoom).onError((error, stackTrace) => handleError(error, stackTrace));
      goTo(newChatRoom);
    }
  }

  Future<ChatRoom?> resolveExistingChatRoom(String? currentUserUid, String? targetUserUid) async {
    return await Db.chatRooms
        .where(FieldPath.fromString("roleFor.$currentUserUid"), isEqualTo: "owner")
        .where(FieldPath.fromString("roleFor.$targetUserUid"), isEqualTo: "owner")
        .limit(1)
        .get()
        .then(
      (querySnapshot) {
        if (querySnapshot.size > 0) {
          return querySnapshot.docs.first.data();
        } else {
          // chat room for currentUserUid & targetUserUid not exist
          return null;
        }
      },
    );
  }

  void goTo(ChatRoom chatRoomToGo) {
    Navigator.pushNamed(context, ChatRoomScreen.routeName, arguments: chatRoomToGo);
  }

  handleError(Object? error, StackTrace stackTrace) {
    print(error);
    print(stackTrace);
  }
}
