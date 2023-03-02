import 'package:flutter_test/flutter_test.dart';
import 'package:unit_tests/utils/validators/todo.dart';

void main() {
  addTitleTests();
  addDescriptionTests();
}

void addTitleTests() {
  late TodoValidator? todoValidator;
  group("Test Todo Title Validators", () {
    setUp(() => {todoValidator = TodoValidator()});

    test("Test with empty title",
        () => {expect(false, todoValidator?.isValidTitle(""))});

    test("Test with title length <= 3 - t1",
        () => {expect(false, todoValidator?.isValidTitle("he"))});

    test("Test with title length <= 3 - t2",
        () => {expect(false, todoValidator?.isValidTitle("hey"))});

    test(
      "Test with title length > 50",
      () => {
        expect(
          false,
          todoValidator
              ?.isValidTitle(List.generate(50, (index) => "s").join("")),
        )
      },
    );

    test(
      "Test with a valid title length",
      () => {
        expect(
          true,
          todoValidator
              ?.isValidTitle(List.generate(10, (index) => "s").join("")),
        )
      },
    );

    tearDown(() => {todoValidator = null});
  });
}

void addDescriptionTests() {
  late TodoValidator? todoValidator;

  group("Test Todo Description Validators", () {
    setUp(() => {todoValidator = TodoValidator()});

    test("Test with empty description",
        () => {expect(false, todoValidator?.isValidDescription(""))});

    test("Test with description length <= 3 - t1",
        () => {expect(false, todoValidator?.isValidDescription("he"))});

    test("Test with description length <= 3 - t2",
        () => {expect(false, todoValidator?.isValidDescription("hey"))});

    test(
      "Test with description length > 50",
      () => {
        expect(
          true,
          todoValidator
              ?.isValidDescription(List.generate(50, (index) => "s").join("")),
        )
      },
    );

    test(
      "Test with a valid description length - 10",
      () => {
        expect(
          true,
          todoValidator
              ?.isValidDescription(List.generate(10, (index) => "s").join("")),
        )
      },
    );

    test(
      "Test with a valid description length - 512",
          () => {
        expect(
          true,
          todoValidator
              ?.isValidDescription(List.generate(512, (index) => "s").join("")),
        )
      },
    );

    test(
      "Test with a valid description length - 1000",
          () => {
        expect(
          true,
          todoValidator
              ?.isValidDescription(List.generate(1000, (index) => "s").join("")),
        )
      },
    );

    test(
      "Test with a valid description length - 1023",
          () => {
        expect(
          true,
          todoValidator
              ?.isValidDescription(List.generate(1023, (index) => "s").join("")),
        )
      },
    );

    tearDown(() => {todoValidator = null});
  });
}
