import 'package:injectable/injectable.dart';
import '../../domain/entities/task.dart';
import 'task_datasource.dart';

@Environment("firebase")
@LazySingleton(as: TaskDataSource)
class FirebaseDataSource implements TaskDataSource {
  @override
  Future<List<Task>> readAll() async {
    return [Task(id: "99", title: "Firebase Task")];
  }

  @override
  Future<void> write(Task item) async {
    print("Saved to Firebase: ${item.title}");
  }

  @override
  Future<void> delete(String id) async {
    print("Deleted from Firebase: $id");
  }
  
 @override
  @disposeMethod
  Future<void> dispose() async {
   
  }
}
