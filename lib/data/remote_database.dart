import 'package:unit_tests/data/db.dart';
import 'package:unit_tests/model/TodoItem.dart';

class RemoteDatabase extends Database {
  Future add(TodoItem item) async {
    await Future.delayed(const Duration(seconds: 1));
    insert(item);
  }
}
