import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;

  const Task({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}

class RecurringTask extends Task {
  final String interval;

  const RecurringTask({
    required super.id,
    required super.title,
    required this.interval,
  });

  @override
  List<Object?> get props => [id, title, interval];
}

class PriorityTask extends Task {
  final int priority;

  const PriorityTask({
    required super.id,
    required super.title,
    this.priority = 1,
  });

  @override
  List<Object?> get props => [id, title, priority];
}