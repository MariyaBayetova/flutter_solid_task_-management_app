import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_application_5/features/tasks/domain/entities/task.dart';
import 'package:flutter_application_5/features/tasks/domain/repositories/task_repository.dart';
import 'package:flutter_application_5/features/tasks/domain/usecases/get_tasks_usecase.dart';

class MockTaskRepository extends Mock implements ITaskRepository {}

void main() {
  late GetTasksUseCase useCase;
  late MockTaskRepository mockRepo;

  setUp(() {
    mockRepo = MockTaskRepository();
    useCase = GetTasksUseCase(mockRepo);
  });

  test('should get tasks from repository', () async {

    final tTasks = [Task(id: '1', title: 'Test Task')];
    when(() => mockRepo.getTasks()).thenAnswer((_) async => tTasks);

    final result = await useCase();

    expect(result, tTasks);
    verify(() => mockRepo.getTasks()).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}