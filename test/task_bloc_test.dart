import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_5/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:flutter_application_5/features/tasks/presentation/bloc/task_event.dart';
import 'package:flutter_application_5/features/tasks/presentation/bloc/task_state.dart';
import 'package:flutter_application_5/features/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:flutter_application_5/features/tasks/domain/usecases/add_task_usecase.dart';
import 'package:flutter_application_5/features/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:flutter_application_5/core/services/task_validator.dart';
import 'package:flutter_application_5/core/services/notification_service.dart';
import 'package:flutter_application_5/features/tasks/domain/entities/task.dart';

class MockGetTasks extends Mock implements GetTasksUseCase {}
class MockAddTask extends Mock implements AddTaskUseCase {}
class MockDeleteTask extends Mock implements DeleteTaskUseCase {}
class MockValidator extends Mock implements TaskValidator {}
class MockNotifier extends Mock implements NotificationService {}

void main() {
  late TaskBloc bloc;
  late MockGetTasks mockGet;
  late MockAddTask mockAdd;
  late MockDeleteTask mockDelete;
  late MockValidator mockValidator;
  late MockNotifier mockNotifier;

  setUp(() {
    mockGet = MockGetTasks();
    mockAdd = MockAddTask();
    mockDelete = MockDeleteTask();
    mockValidator = MockValidator();
    mockNotifier = MockNotifier();
    
    bloc = TaskBloc(mockGet, mockAdd, mockDelete, mockValidator, mockNotifier);
  });

  tearDown(() => bloc.close());

  final tTasks = [Task(id: '1', title: 'Test Task')];

  blocTest<TaskBloc, TaskState>(
    'emits [TaskLoading, TaskLoaded] when LoadTasksEvent is added',
    build: () {
      when(() => mockGet.call()).thenAnswer((_) async => tTasks);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTasksEvent()),
    expect: () => [
      isA<TaskLoading>(),
      isA<TaskLoaded>().having((s) => s.tasks, 'tasks', tTasks),
    ],
  );
}