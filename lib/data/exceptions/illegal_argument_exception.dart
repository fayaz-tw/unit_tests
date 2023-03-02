import 'package:unit_tests/data/exceptions/db_exception.dart';

class IllegalArgumentException extends DBException {
  IllegalArgumentException(message) : super(message);
}
