import 'package:unit_tests/model/TodoItem.dart';

class Database {
  static final List<TodoItem> _todos = [];

  int getCount() {
    return _todos.length;
  }

  int getNewId() {
    return _todos.length + 1;
  }

  void insert(TodoItem item) {
    _todos.add(item);
  }

  void truncate() {
    _todos.clear();
  }

  TodoItem? findByIndex(int index) {
    if (index >= _todos.length) {
      return null;
    }
    return _todos[index];
  }

  TodoItem? findById(int id) {
    final searchRecord = _todos.singleWhere(
      (element) => element.id == id,
      orElse: () => TodoItem("", "", -1, false, -1),
    );

    if (searchRecord.id == -1) {
      return null;
    }

    return searchRecord;
  }

  void updateById(int id, TodoItem record) {
    _todos.replaceRange(id, id, Iterable.generate(1, (e) => record));
  }
}
