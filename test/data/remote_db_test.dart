import 'package:flutter_test/flutter_test.dart';
import 'package:unit_tests/model/TodoItem.dart';

import '../services/remote_db.dart';

void main() {
  group("Test Remote db", () {
    test("Test add", () async {
      fakeRemoteDb.truncate();

      expect(fakeRemoteDb.getCount(), equals(0));
      await fakeRemoteDb
          .add(TodoItem("title", "description", 23434334433434, false, 10));

      expect(fakeRemoteDb.getCount(), equals(1));
    });
  });
}
