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
        () => {expect(todoValidator?.isValidTitle(""), false)});

    test("Test with title length <= 3 - t1",
        () => {expect(todoValidator?.isValidTitle("he"), false)});

    test("Test with title length <= 3 - t2",
        () => {expect(todoValidator?.isValidTitle("hey"), false)});

    test(
      "Test with title length > 50",
      () => {
        expect(
          todoValidator
              ?.isValidTitle(List.generate(50, (index) => "s").join("")),
          false,
        )
      },
    );

    test(
      "Test with a valid title length",
      () => {
        expect(
          todoValidator
              ?.isValidTitle(List.generate(10, (index) => "s").join("")),
          true,
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
        () => {expect(todoValidator?.isValidDescription(""), false)});

    test("Test with description length <= 3 - t1",
        () => {expect(todoValidator?.isValidDescription("he"), false)});

    test("Test with description length <= 3 - t2",
        () => {expect(todoValidator?.isValidDescription("hey"), false)});

    test(
      "Test with description length > 50",
      () => {
        expect(
          todoValidator
              ?.isValidDescription(List.generate(50, (index) => "s").join("")),
          true,
        )
      },
    );

    test(
      "Test with a valid description length - 10",
      () => {
        expect(
          todoValidator
              ?.isValidDescription(List.generate(10, (index) => "s").join("")),
          true,
        )
      },
    );

    test(
      "Test with a valid description length - 512",
      () => {
        expect(
          todoValidator
              ?.isValidDescription(List.generate(512, (index) => "s").join("")),
          true,
        )
      },
    );

    test(
      "Test with a valid description length - 1000",
      () => {
        expect(
          todoValidator?.isValidDescription(
              List.generate(1000, (index) => "s").join("")),
          true,
        )
      },
    );

    test(
      "Test with a valid description length - 1023",
      () => {
        expect(
          todoValidator?.isValidDescription(
              List.generate(1023, (index) => "s").join("")),
          true,
        )
      },
    );

    tearDown(() => {todoValidator = null});
  });
}
