import 'package:injectable/injectable.dart';

@singleton
class TaskValidator {
  bool isValid(String title) {
    return title.isNotEmpty;
  }
}
