import 'package:flutter/material.dart';

import 'photo_url_broken.dart';

class ContactListItemAvatar extends StatelessWidget {
  const ContactListItemAvatar({
    Key? key,
    required this.photoUrl,
    required this.avatarSize,
  }) : super(key: key);

  final String? photoUrl;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return photoUrl != null
        ? _ImageAvatar(photoUrl: photoUrl, avatarSize: avatarSize)
        : _DefaultAvatar(avatarSize: avatarSize);
  }
}

class _ImageAvatar extends StatelessWidget {
  const _ImageAvatar({
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
      errorBuilder: (context, error, stackTrace) => PhotoUrlBroken(avatarSize: avatarSize),
    );
  }
}

class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar({
    Key? key,
    required this.avatarSize,
  }) : super(key: key);

  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.account_circle,
      size: avatarSize,
    );
  }
}
