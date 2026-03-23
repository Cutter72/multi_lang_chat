import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import '../../model/passives/daos/app_user/app_user.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
late AppUser loggedAppUser;

String get lauUid => loggedAppUser.uid ?? "";

final List<AuthProvider> authProviders = [EmailAuthProvider()];

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
