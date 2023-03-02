import 'package:unit_tests/data/db.dart';

class FakeDatabase extends Database {
  @override
  void truncate() {
    super.truncate();
  }
}
