import 'package:injectable/injectable.dart';
import '../../domain/entities/task.dart';
import 'task_datasource.dart';

@Environment("dev")
@LazySingleton(as: TaskDataSource)
class MockTaskDataSource implements TaskDataSource {
  final List<Task> _tasks = [
    Task(id: '1', title: 'Mock Task (Dev Mode)'),
    Task(id: '2', title: 'Check SOLID Principles'),
  ];

  @override
  Future<List<Task>> readAll() async => List.from(_tasks);

  @override
  Future<void> write(Task task) async => _tasks.add(task);

  @override
  Future<void> delete(String id) async => _tasks.removeWhere((t) => t.id == id);
  
  @override
  @disposeMethod
  Future<void> dispose() async {
    _tasks.clear();
    print("MockDataSource disposed");
  }
}