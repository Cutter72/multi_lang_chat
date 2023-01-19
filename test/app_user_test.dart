import 'package:multi_lang_chat/model/firestore/app_user/app_user.dart';
import 'package:test/test.dart';

/// AppUser test class
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
void main() {
  test('AppUser JSON/Map (de)serialization', () {
    // GIVEN
    var person1 = AppUser(displayName: "dasd xxv");
    var person2 = AppUser(displayName: "yyy");
    var person3 = AppUser(displayName: "dasd xxv");

    // THEN
    expect(person1, equals(AppUserMapper.fromJson(person1.toJson())));
    expect(person1, equals(AppUserMapper.fromMap(person1.toMap())));
    expect(person1, equals(person3));
    expect(person1, equals(person1.copyWith(uid: null)));
    expect(person1, isNot(person2));
  });
}
