import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../../../../model/actives/app_logger.dart';
import '../../../../../model/passives/dtos/chat_room_data.dart';
import '../../../../common/screens/sections/components/molecules/atoms/content_text_atom.dart';
import '../../../../common/screens/sections/components/molecules/atoms/waiting_indicator_atom.dart';
import 'msg_bubble_date_time.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("MsgBubble");

class MsgBubble extends StatelessWidget {
  final String content;
  final DateTime timeSent;
  final bool isOwner;
  final ChatRoomData chatRoomData;

  const MsgBubble({
    required this.content,
    required this.timeSent,
    required this.isOwner,
    required this.chatRoomData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _prepareCardAlignment(isOwner),
      child: Card(
          surfaceTintColor: _prepareCardColor(isOwner),
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: _prepareBorderRadius(isOwner)),
          margin: _prepareMargin(isOwner),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: _prepareCardContentAlignment(isOwner),
              children: [
                MsgBubbleDateTime(timeSent: timeSent),
                Padding(
                  padding: _preparePadding(isOwner),
                  child: FutureBuilder(
                    future: _translateContentIfNeeded(content),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return IntrinsicWidth(child: const WaitingIndicator());
                      } else {
                        return ContentTextHH("${snapshot.data}");
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Alignment _prepareCardAlignment(bool isOwner) {
    if (isOwner) {
      return Alignment.centerRight;
    } else {
      return Alignment.centerLeft;
    }
  }

  Color _prepareCardColor(bool isOwner) {
    if (isOwner) {
      return Colors.black;
    } else {
      return Colors.deepPurpleAccent;
    }
  }

  BorderRadius _prepareBorderRadius(bool isOwner) {
    if (isOwner) {
      return const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      );
    } else {
      return const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
        bottomRight: Radius.circular(12),
      );
    }
  }

  CrossAxisAlignment _prepareCardContentAlignment(bool isOwner) {
    if (isOwner) {
      return CrossAxisAlignment.end;
    } else {
      return CrossAxisAlignment.start;
    }
  }

  EdgeInsets _prepareMargin(bool isOwner) {
    if (isOwner) {
      return const EdgeInsets.only(left: 30, right: 4, top: 4, bottom: 4);
    } else {
      return const EdgeInsets.only(right: 30, left: 4, top: 4, bottom: 4);
    }
  }

  EdgeInsets _preparePadding(bool isOwner) {
    if (isOwner) {
      return const EdgeInsets.only(left: 2);
    } else {
      return const EdgeInsets.only(right: 2);
    }
  }

  Future<String> _translateContentIfNeeded(String originalText) async {
    if (chatRoomData.isTranslationEnabled && !isOwner) {
      return await originalText
          .translate(to: chatRoomData.selectedLanguageKey)
          .then((translation) => '${translation.text}\n"$originalText"')
          .onError((error, stackTrace) => _logger.eAsync(
              "Error translating msg content",
              error: error,
              stackTrace: stackTrace));
    } else {
      return originalText;
    }
  }
}
