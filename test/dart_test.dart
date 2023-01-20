import 'package:test/test.dart';

/// AppUser test class
///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
void main() {
  test('Dart testing', () {
    var map = {
      1: "1",
      2: "2",
      3: "3",
    };

    map.update(
      4,
      (value) => "newValue",
      ifAbsent: () => "wasAbsent",
    );
    print(map);
  });
}
