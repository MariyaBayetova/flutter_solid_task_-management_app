import 'package:injectable/injectable.dart';
import '../datasources/task_datasource.dart';
import '../models/task_model.dart'; 
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

@LazySingleton(as: ITaskRepository)
class TaskRepositoryImpl implements ITaskRepository {
  final TaskDataSource dataSource;

  TaskRepositoryImpl(this.dataSource);

  @override
  Future<List<Task>> getTasks() async {
    final rawTasks = await dataSource.readAll();
    return rawTasks;
  }

  @override
  Future<void> addTask(Task task) async {

    final model = TaskModel(id: task.id, title: task.title);
    await dataSource.write(model);
  }
  
  @override
  Future<void> deleteTask(String id) async {
    await dataSource.delete(id);
  }
}