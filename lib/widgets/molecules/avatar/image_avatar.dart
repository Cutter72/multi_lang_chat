import 'package:flutter/material.dart';

import '../../atoms/content_text.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class ImageAvatar extends StatelessWidget {
  const ImageAvatar({
    Key? key,
    required this.photoUrl,
    required this.avatarSize,
  }) : super(key: key);

  final String? photoUrl;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      photoUrl!,
      width: avatarSize,
      height: avatarSize,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
          frame == null ? const CircularProgressIndicator() : child,
      errorBuilder: (context, error, stackTrace) => _AvatarUrlBroken(avatarSize: avatarSize),
    );
  }
}

class _AvatarUrlBroken extends StatelessWidget {
  const _AvatarUrlBroken({
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
          ContentTextHHH("Avatar URL broken.")
        ],
      ),
    );
  }
}
