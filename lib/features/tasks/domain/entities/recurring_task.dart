import 'task.dart';

class RecurringTask extends Task {
  final int intervalDays;

  RecurringTask({
    required super.id,
    required super.title,
    required this.intervalDays,
  });
}
