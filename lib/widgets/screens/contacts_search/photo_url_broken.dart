import 'package:flutter/material.dart';
import 'package:multi_lang_chat/widgets/atoms/content_text.dart';

class PhotoUrlBroken extends StatelessWidget {
  const PhotoUrlBroken({
    Key? key,
    required this.avatarSize,
  }) : super(key: key);

  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: avatarSize,
      width: avatarSize,
      child: Stack(
        children: const [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.error,
              size: 18,
              color: Colors.red,
            ),
          ),
          ContentTextHHH("Photo URL broken.")
        ],
      ),
    );
  }
}
