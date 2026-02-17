import '../../domain/entities/task.dart';
import 'interfaces.dart';

abstract class TaskDataSource
    implements Readable<Task>, Writable<Task>, Deletable {
  dispose() {}}
