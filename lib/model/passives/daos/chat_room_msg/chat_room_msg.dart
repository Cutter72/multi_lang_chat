import 'package:dart_mappable/dart_mappable.dart';

part 'chat_room_msg.mapper.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
@MappableClass()
class ChatRoomMsg with ChatRoomMsgMappable {
  final Map<String?, String> roleFor;
  final String content;
  final int timeSentMillis;

  ChatRoomMsg({required this.content, required this.timeSentMillis, required this.roleFor});

  ChatRoomMsg.create(String content, String ownerId)
      : this(
    content: content,
    timeSentMillis: DateTime
        .now()
        .millisecondsSinceEpoch,
    roleFor: {ownerId: "owner"},
  );
}
