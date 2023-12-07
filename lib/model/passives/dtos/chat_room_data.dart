import 'package:dart_mappable/dart_mappable.dart';

import '../daos/app_user/app_user.dart';
import '../daos/chat_room/chat_room.dart';

part 'chat_room_data.mapper.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
@MappableClass()
class ChatRoomData with ChatRoomDataMappable {
  final ChatRoom chatRoom;
  final AppUser contactAppUser;

  ChatRoomData({required this.chatRoom, required this.contactAppUser});
}
