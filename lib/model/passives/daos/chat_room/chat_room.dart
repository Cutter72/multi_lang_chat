import 'package:dart_mappable/dart_mappable.dart';

part 'chat_room.mapper.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
@MappableClass()
class ChatRoom with ChatRoomMappable {
  final Map<String?, String> roleFor;

  ChatRoom({required this.roleFor});

  ChatRoom.forPrivateConversation(String currentUserId, String targetUserId)
      : this(roleFor: {currentUserId: "owner", targetUserId: "owner"});
}
