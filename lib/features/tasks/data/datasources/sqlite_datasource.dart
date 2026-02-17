import 'package:injectable/injectable.dart';
import '../../domain/entities/task.dart';
import 'task_datasource.dart';

@Environment("sqlite")
@LazySingleton(as: TaskDataSource)
class SQLiteDataSource implements TaskDataSource {
  @override
  Future<List<Task>> readAll() async {
    return [Task(id: "50", title: "SQLite Task")];
  }

  @override
  Future<void> write(Task item) async {
    print("Saved to SQLite: ${item.title}");
  }

  @override
  Future<void> delete(String id) async {
    print("Deleted from SQLite: $id");
  }
  @override
  @disposeMethod
  Future<void> dispose() async {
  
  }
}
