import 'package:flutter/material.dart';

import '../../../../../model/actives/app_logger.dart';
import '../../../../../model/actives/translator.dart';
import '../../../../common/screens/sections/components/molecules/atoms/content_text_atom.dart';
import '../../../../common/screens/sections/components/molecules/atoms/waiting_indicator_atom.dart';
import 'msg_bubble_date_time.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
final AppLogger _logger = AppLogger.get("MsgBubble");

class MsgBubble extends StatelessWidget {
  final String _content;
  final DateTime _timeSent;
  final bool _isOwner;
  final bool _isTranslationEnabled;
  final Translator _translator;

  const MsgBubble({
    required String content,
    required DateTime timeSent,
    required bool isOwner,
    required bool isTranslationEnabled,
    required translator,
    Key? key,
  })  : _content = content,
        _timeSent = timeSent,
        _isOwner = isOwner,
        _isTranslationEnabled = isTranslationEnabled,
        _translator = translator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _prepareCardAlignment(_isOwner),
      child: Card(
          surfaceTintColor: _prepareCardColor(_isOwner),
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: _prepareBorderRadius(_isOwner)),
          margin: _prepareMargin(_isOwner),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: _prepareCardContentAlignment(_isOwner),
              children: [
                MsgBubbleDateTime(timeSent: _timeSent),
                Padding(
                  padding: _preparePadding(_isOwner),
                  child: FutureBuilder(
                    future: _translateContentIfNeeded(_content),
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
    if (_isTranslationEnabled && !_isOwner) {
      return await _translator
          .translate(originalText)
          .then((translation) => '${translation}\n"$originalText"')
          .onError((error, stackTrace) => _logger.eAsync(
              "Error translating msg content",
              error: error,
              stackTrace: stackTrace));
    } else {
      return originalText;
    }
  }
}
