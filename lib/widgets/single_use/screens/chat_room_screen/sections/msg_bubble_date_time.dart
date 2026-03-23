import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/screens/sections/components/molecules/atoms/content_text_atom.dart';

class MsgBubbleDateTime extends StatelessWidget {
  const MsgBubbleDateTime({
    super.key,
    required this.timeSent,
  });

  final DateTime timeSent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: ContentTextHHH(
        DateFormat.E(Intl.systemLocale)
            .add_d()
            .add_LLL()
            .add_y()
            .add_Hms()
            .format(timeSent),
      ),
    );
  }
}
