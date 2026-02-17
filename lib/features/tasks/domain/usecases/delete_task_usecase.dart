import 'package:injectable/injectable.dart';
import '../repositories/task_repository.dart';

@injectable
class DeleteTaskUseCase {
  final ITaskRepository repo;

  DeleteTaskUseCase(this.repo);

  Future<void> call(String id) async {
    await repo.deleteTask(id);
  }
}
