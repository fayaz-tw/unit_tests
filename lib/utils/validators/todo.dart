class TodoValidator {
  static bool isValidTitle(String title) {
    return title.isNotEmpty && title.length > 3 && title.length < 50;
  }

  static bool isValidDescription(String description) {
    return description.isNotEmpty &&
        description.length > 3 &&
        description.length < 1024;
  }
}
