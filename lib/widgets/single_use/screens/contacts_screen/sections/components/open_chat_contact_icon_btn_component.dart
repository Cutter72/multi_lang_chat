import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_lang_chat/model/actives/app_logger.dart';

import '../../../../../../model/passives/daos/app_user/app_user.dart';
import '../../../../../../model/passives/daos/chat_room/chat_room.dart';
import '../../../../../../storage/persistent/firestore/db.dart';
import '../../../../../../storage/runtime/app_globals.dart';
import '../../../chat_room_screen/chat_room_screen.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("OpenChatContactIconBtn");

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
      onPressed: () => _goToPrivateChatRoomWith(widget.user),
      icon: const Icon(
        Icons.chat,
        color: Colors.green,
      ),
    );
  }

  _goToPrivateChatRoomWith(AppUser targetUser) async {
    _logger.v("goToPrivateChatRoomWith");
    ChatRoom? existingChatRoom = await _resolveExistingChatRoom(lauUid, targetUser.uid);
    if (existingChatRoom != null) {
      _goTo(existingChatRoom);
    } else {
      var newChatRoom = ChatRoom.forPrivateConversation(Db.chatRooms.doc().id, lauUid, targetUser.uid!);
      _saveNewPrivateChatRoomToDb(newChatRoom);
      _goTo(newChatRoom);
    }
  }

  void _saveNewPrivateChatRoomToDb(ChatRoom newChatRoom) {
    _logger.d("saveNewPrivateChatRoomToDb: ${newChatRoom.uid}");
    Db.chatRooms.doc(newChatRoom.uid).set(newChatRoom).onError((error, stackTrace) =>
        _logger.asyncE("Failed to create a new chat room", stackTrace: stackTrace, error: error));
  }

  Future<ChatRoom?> _resolveExistingChatRoom(String? currentUserUid, String? targetUserUid) async {
    _logger.v("resolveExistingChatRoom");
    return await Db.chatRooms
        .where(FieldPath.fromString("roleFor.$currentUserUid"), isEqualTo: "owner")
        .where(FieldPath.fromString("roleFor.$targetUserUid"), isEqualTo: "owner")
        .limit(1)
        .get()
        .then(
      (querySnapshot) {
        if (querySnapshot.size > 0) {
          _logger.d("Chat room for target $targetUserUid exist");
          return querySnapshot.docs.first.data();
        } else {
          _logger.d("Chat room for target $targetUserUid not exist");
          return null;
        }
      },
    ).onError((error, stackTrace) =>
            _logger.asyncE("Failed to resolve an existing chat room", stackTrace: stackTrace, error: error));
  }

  void _goTo(ChatRoom chatRoomToGo) {
    _logger.d("goTo: ${chatRoomToGo.uid}");
    Navigator.pushNamed(context, ChatRoomScreen.routeName, arguments: chatRoomToGo);
  }
}
