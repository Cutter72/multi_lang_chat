import 'package:dart_mappable/dart_mappable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../keywords.dart';

part 'app_user.mapper.dart';

/// Class to reflect this app user data in database
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
/// https://pub.dev/documentation/dart_mappable/2.0.0-dev.11/index.html
@MappableClass()
class AppUser extends Keywords with AppUserMappable {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  AppUser({super.keywords, this.uid, this.email, this.displayName, this.photoURL})
      : super.from(searchableTexts: [
          email?.split("@").first,
          displayName,
        ]);

  AppUser.fromUser(User user)
      : uid = user.uid,
        email = user.email,
        displayName = user.displayName,
        photoURL = user.photoURL,
        super.from(searchableTexts: [
          user.email?.split("@").first,
          user.displayName,
        ]);
}
