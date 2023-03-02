import 'package:flutter_test/flutter_test.dart';
import 'package:unit_tests/data/db_helper.dart';
import 'package:unit_tests/data/exceptions/illegal_argument_exception.dart';
import 'package:unit_tests/data/exceptions/not_found_exception.dart';

import '../services/db.dart';

void main() {
  testAddTodoItem();
  testUpdateTodoItem();
}

void testAddTodoItem() {
  late DatabaseHelper helper;

  group("Test adding todo items to db", () {
    setUp(() => {helper = DatabaseHelper(fakeDatabase)});

    test("add basic todo item", () {
      expect(helper.recordsCount(), 0);

      final dueTomorrow = DateTime.now().add(const Duration(days: 1));

      helper.add(
        "Initiate Project",
        "Need to start a new project",
        dueTomorrow.millisecondsSinceEpoch,
      );

      expect(helper.recordsCount(), 1);

      expect(helper.recordAt(0), isNotNull);
      expect(helper.recordAt(0)!.completed, isFalse);
    });

    test("add todo item with invalid due date", () {
      final currentCount = helper.recordsCount();
      final dueTomorrow = DateTime.now().add(const Duration(days: -1));

      expect(
            () =>
            helper.add(
              "Initiate Project",
              "Need to start a new project",
              dueTomorrow.millisecondsSinceEpoch,
            ),
        throwsException,
      );

      expect(
            () =>
            helper.add(
              "Initiate Project",
              "Need to start a new project",
              dueTomorrow.millisecondsSinceEpoch,
            ),
        throwsA(isA<IllegalArgumentException>()),
      );

      expect(helper.recordsCount(), currentCount);
    });

    tearDown(() => {helper.clear()});
  });
}

void testUpdateTodoItem() {
  late DatabaseHelper helper;

  group("Test Updating todo item as complete, incomplete", () {
    setUp(() {
      fakeDatabase.truncate();
      helper = DatabaseHelper(fakeDatabase);
    });

    tearDown(() => {helper.clear()});

    test("Test mark as completed", () {
      final dueTomorrow = DateTime.now().add(const Duration(days: 1));
      helper.add(
        "Initiate Project",
        "Need to start a new project",
        dueTomorrow.millisecondsSinceEpoch,
      );

      expect(helper.recordsCount(), 1);

      final firstRecord = helper.recordAt(0);
      expect(firstRecord!.completed, isFalse);

      expect(() => helper.markCompleted(0), throwsA(isA<NotFoundException>()));

      helper.markCompleted(firstRecord.id);

      expect(helper.recordAt(0)!.completed, isTrue);
    });

    test("Test mark as incomplete", () {
      helper.clear();
      final dueTomorrow = DateTime.now().add(const Duration(days: 1));
      helper.add(
        "Initiate Project",
        "Need to start a new project",
        dueTomorrow.millisecondsSinceEpoch,
      );

      expect(helper.recordsCount(), 1);

      final firstRecord = helper.recordAt(0);
      expect(firstRecord!.completed, isFalse);

      expect(() => helper.markCompleted(0), throwsA(isA<NotFoundException>()));

      helper.markCompleted(firstRecord.id);

      expect(helper.recordAt(0)!.completed, isTrue);

      helper.markInComplete(firstRecord.id);

      expect(helper.recordAt(0)!.completed, isFalse);
    });
  });
}
