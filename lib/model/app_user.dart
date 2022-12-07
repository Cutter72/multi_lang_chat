import 'package:firebase_auth/firebase_auth.dart';

/// Class to reflect this app user data in database
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class AppUser {
  static const String _emailKey = "email";
  static const String _displayNameKey = "displayName";
  static const String _photoURLKey = "photoURL";
  final String? email;
  final String? displayName;
  final String? photoURL;

  AppUser.fromUser(User user)
      : email = user.email,
        displayName = user.displayName,
        photoURL = user.photoURL;

  AppUser.fromSnapshotData(Map<String, dynamic> fieldsMap)
      : email = fieldsMap[_emailKey],
        displayName = fieldsMap[_displayNameKey],
        photoURL = fieldsMap[_photoURLKey];

  Map<String, dynamic> toMap() {
    return {
      _emailKey: email,
      _displayNameKey: displayName,
      _photoURLKey: photoURL,
    };
  }
}
