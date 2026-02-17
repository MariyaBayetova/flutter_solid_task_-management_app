import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/task_validator.dart';
import '../../../../core/services/notification_service.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasks;
  final AddTaskUseCase addTask;
  final DeleteTaskUseCase deleteTask;
  final TaskValidator validator;
  final NotificationService notifier;

  TaskBloc(
    this.getTasks,
    this.addTask,
    this.deleteTask,
    this.validator,
    this.notifier,
  ) : super(TaskInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final tasks = await getTasks();
    emit(TaskLoaded(List.from(tasks)));
  }

  Future<void> _onAddTask(
      AddTaskEvent event, Emitter<TaskState> emit) async {
    if (!validator.isValid(event.title)) {
      emit(TaskError("Task title cannot be empty!"));
      return;
    }

    final newTask = Task(
      id: const Uuid().v4(),
      title: event.title,
    );

    await addTask(newTask);
    notifier.notify("Task Added: ${event.title}");

    final updatedTasks = await getTasks();
    emit(TaskLoaded(List.from(updatedTasks)));
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    await deleteTask(event.id);
    notifier.notify("Task Deleted");

    final updatedTasks = await getTasks();
    emit(TaskLoaded(List.from(updatedTasks)));
  }
}