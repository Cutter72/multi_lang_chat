import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/screens/sections/components/molecules/atoms/content_text_atom.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class MsgBubble extends StatelessWidget {
  final String content;
  final DateTime timeSent;
  final Color color;
  final AlignmentGeometry alignment;
  final bool isOwner;

  const MsgBubble({
    required this.content,
    required this.timeSent,
    required this.color,
    required this.alignment,
    required this.isOwner,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: _prepareBorderRadius(isOwner),
          ),
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ContentTextHHH(DateFormat.E(Intl.systemLocale).add_d().add_LLL().add_y().add_Hms().format(timeSent)),
              ContentTextHH(content),
            ],
          )),
    );
  }

  BorderRadius _prepareBorderRadius(bool isOwner) {
    if (isOwner) {
      return const BorderRadius.only(
        topLeft: Radius.circular(6),
        topRight: Radius.circular(6),
        bottomLeft: Radius.circular(6),
      );
    } else {
      return const BorderRadius.only(
        topLeft: Radius.circular(6),
        topRight: Radius.circular(6),
        bottomRight: Radius.circular(6),
      );
    }
  }
}
