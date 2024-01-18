import 'package:flutter/material.dart';

import '../../../../model/actives/app_logger.dart';
import '../../../../model/passives/dtos/chat_room_data.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("TranslateSwitch");

class TranslateSwitch extends StatelessWidget {
  final _chatRoomData;
  final _onChange;

  const TranslateSwitch({
    Key? key,
    required ChatRoomData chatRoomData,
    required void Function(bool) onChange,
  })  : _chatRoomData = chatRoomData,
        _onChange = onChange,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.75,
      child: Switch(
        value: _chatRoomData.isTranslationEnabled,
        onChanged: (isTranslationEnabledNewValue) =>
            _onChange(isTranslationEnabledNewValue),
      ),
    );
  }
}
