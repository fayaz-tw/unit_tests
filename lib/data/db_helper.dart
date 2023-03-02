import 'package:unit_tests/data/db.dart';
import 'package:unit_tests/data/exceptions/not_found_exception.dart';
import 'package:unit_tests/model/TodoItem.dart';
import 'exceptions/illegal_argument_exception.dart';

class DatabaseHelper {
  final Database _db;

  DatabaseHelper(this._db);

  void add(String title, String description, int dueOn) {
    final newRecord =
        TodoItem(title, description, dueOn, false, _db.getNewId());
    final now = DateTime.now().millisecondsSinceEpoch;
    if (dueOn < now) {
      throw IllegalArgumentException(
          "Invalid dueOn value, should be after current time");
    }
    _db.insert(newRecord);
  }

  void markCompleted(int id) {
    final record = _db.findById(id);
    if (record == null) {
      throw NotFoundException("Record not found for passed id");
    }

    record.completed = true;
    _db.updateById(id, record);
  }

  void markInComplete(int id) {
    final record = _db.findById(id);
    if (record == null) {
      throw NotFoundException("Record not found for passed id");
    }

    record.completed = false;
    _db.updateById(id, record);
  }

  int recordsCount() {
    return _db.getCount();
  }

  TodoItem? recordAt(int index) {
    return _db.findByIndex(index);
  }
}
