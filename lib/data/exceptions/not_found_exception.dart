import 'package:unit_tests/data/exceptions/db_exception.dart';

class NotFoundException extends DBException {
  NotFoundException(message) : super(message);
}
