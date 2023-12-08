import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/screens/sections/components/molecules/atoms/content_text_atom.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class MsgBubble extends StatelessWidget {
  final String content;
  final DateTime timeSent;
  final bool isOwner;

  const MsgBubble({
    required this.content,
    required this.timeSent,
    required this.isOwner,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _prepareCardAlignment(isOwner),
      child: Card(
          surfaceTintColor: _prepareCardColor(isOwner),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: _prepareBorderRadius(isOwner)),
          margin: const EdgeInsets.all(4),
          child: Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: _prepareCardContentAlignment(isOwner),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: ContentTextHHH(
                    DateFormat.E(Intl.systemLocale).add_d().add_LLL().add_y().add_Hms().format(timeSent),
                  ),
                ),
                Padding(
                  padding: _preparePadding(isOwner),
                  child: ContentTextHH(content),
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

  EdgeInsets _preparePadding(bool isOwner) {
    if (isOwner) {
      return const EdgeInsets.only(left: 2);
    } else {
      return const EdgeInsets.only(right: 2);
    }
  }
}
