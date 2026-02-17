import 'package:injectable/injectable.dart';
import '../../features/tasks/domain/entities/task.dart';

@singleton
class TaskReportGenerator {
  String generateReport(List<Task> tasks) {
    return "Total Tasks: ${tasks.length}";
  }
}
