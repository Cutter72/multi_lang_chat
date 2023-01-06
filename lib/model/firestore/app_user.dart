import 'package:firebase_auth/firebase_auth.dart';

import 'keywords.dart';

/// Class to reflect this app user data in database
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AppUser extends Keywords {
  static const String _uidKey = "uid";
  static const String _emailKey = "email";
  static const String _displayNameKey = "displayName";
  static const String _photoURLKey = "photoURL";
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  AppUser.fromUser(User user)
      : uid = user.uid,
        email = user.email,
        displayName = user.displayName,
        photoURL = user.photoURL,
        super(searchableTexts: [
          user.email?.split("@").first,
          user.displayName,
        ]);

  AppUser.fromSnapshotData(Map<String, dynamic> fieldsMap)
      : uid = fieldsMap[_uidKey],
        email = fieldsMap[_emailKey],
        displayName = fieldsMap[_displayNameKey],
        photoURL = fieldsMap[_photoURLKey],
        super(
          keywords: Set<String>.from(fieldsMap[Keywords.keywordsKey] ?? {}),
          searchableTexts: [
            (fieldsMap[_emailKey] as String?)?.split("@").first,
            fieldsMap[_displayNameKey],
          ],
        );

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        _uidKey: uid,
        _emailKey: email,
        _displayNameKey: displayName,
        _photoURLKey: photoURL,
      });
  }

  @override
  String toString() {
    return '${runtimeType.toString()}{${super.keywords}: $keywords, $_uidKey: $uid, $_emailKey: ${email?.split("@").first}, $_displayNameKey: $displayName, $_photoURLKey: $photoURL}';
  }
}
