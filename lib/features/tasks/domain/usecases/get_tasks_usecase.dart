import 'package:injectable/injectable.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

@injectable
class GetTasksUseCase {
  final ITaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<Task>> call() async {
    return await repository.getTasks();
  }
}
