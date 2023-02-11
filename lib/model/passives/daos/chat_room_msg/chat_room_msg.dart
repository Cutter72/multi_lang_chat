import 'package:dart_mappable/dart_mappable.dart';

part 'chat_room_msg.mapper.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
@MappableClass()
class ChatRoomMsg with ChatRoomMsgMappable {
  final Map<String?, String> roleFor;
  final String content;
  final DateTime timeSent;

  ChatRoomMsg({required this.content, required this.timeSent, required this.roleFor});

  ChatRoomMsg.create(String content, String currentUserId)
      : this(
          content: content,
          timeSent: DateTime.now(),
          roleFor: {currentUserId: "owner"},
        );
}
