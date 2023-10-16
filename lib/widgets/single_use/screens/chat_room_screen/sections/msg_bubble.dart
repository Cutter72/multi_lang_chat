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

  const MsgBubble({
    required this.content,
    required this.timeSent,
    required this.color,
    required this.alignment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
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
}
