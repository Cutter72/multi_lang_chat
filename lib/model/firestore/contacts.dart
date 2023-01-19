import 'package:dart_mappable/dart_mappable.dart';
import 'package:multi_lang_chat/model/firestore/app_user/app_user.dart';

part 'contacts.mapper.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
@MappableClass()
class Contacts with ContactsMappable {
  final List<AppUser> accepted;
  final List<AppUser> rejected;
  final List<AppUser> pending;

  Contacts({required this.accepted, required this.rejected, required this.pending});
}
