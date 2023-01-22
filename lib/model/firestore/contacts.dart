import 'package:dart_mappable/dart_mappable.dart';

import 'app_user/app_user.dart';

part 'contacts.mapper.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
@MappableClass()
class Contacts with ContactsMappable {
  final Map<String?, AppUser> accepted;
  final Map<String?, AppUser> rejected;
  final Map<String?, AppUser> pending;

  Contacts({required this.accepted, required this.rejected, required this.pending});

  Contacts update(AppUser appUser) {
    if (accepted.containsKey(appUser.uid)) {
      accepted[appUser.uid] = appUser;
    }
    if (rejected.containsKey(appUser.uid)) {
      rejected[appUser.uid] = appUser;
    }
    if (pending.containsKey(appUser.uid)) {
      pending[appUser.uid] = appUser;
    }
    return this;
  }
}
