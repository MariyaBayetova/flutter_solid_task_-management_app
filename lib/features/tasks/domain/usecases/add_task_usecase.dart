import 'package:injectable/injectable.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

@injectable
class AddTaskUseCase {
  final ITaskRepository repo;

  AddTaskUseCase(this.repo);

  Future<void> call(Task task) async {
    await repo.addTask(task);
  }
}
