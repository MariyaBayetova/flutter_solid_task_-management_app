import 'task.dart';

class PriorityTask extends Task {
  final int priority;

  PriorityTask({
    required super.id,
    required super.title,
    required this.priority,
  });
}
