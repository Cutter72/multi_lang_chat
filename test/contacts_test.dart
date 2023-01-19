import 'package:multi_lang_chat/model/firestore/app_user/app_user.dart';
import 'package:multi_lang_chat/model/firestore/contacts.dart';
import 'package:test/test.dart';

/// Contacts test class
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
void main() {
  test('Contacts JSON/Map (de)serialization', () {
    // GIVEN
    var person1 = AppUser(displayName: "yyy");
    var person2 = AppUser(displayName: "dasd xxv");
    var contacts1 = Contacts(accepted: [person2, person1], rejected: [], pending: []);
    var contacts2 = Contacts(accepted: [person1, person2], rejected: [], pending: []);
    var contacts3 = Contacts(accepted: [person1], rejected: [], pending: [person2]);

    // THEN
    expect(contacts1, equals(ContactsMapper.fromJson(contacts1.toJson())));
    expect(contacts1, equals(ContactsMapper.fromMap(contacts1.toMap())));
    expect(contacts1, equals(contacts2.copyWith(accepted: contacts2.accepted.reversed.toList())));
    expect(contacts1, equals(contacts3.copyWith(accepted: [person2, person1], pending: [])));
    expect(contacts1, isNot(contacts3));
  });
}
