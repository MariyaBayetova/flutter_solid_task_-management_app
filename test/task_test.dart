import 'package:flutter_application_5/features/tasks/domain/entities/task.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Task Entities LSP Check', () {
    test('Tasks with same properties should be equal (LSP Check)', () {
      const task1 = PriorityTask(id: '1', title: 'Test', priority: 5);
      const task2 = PriorityTask(id: '1', title: 'Test', priority: 5);
      const task3 = Task(id: '1', title: 'Test');


      expect(task1, equals(task2)); 
      expect(task1, isNot(equals(task3))); 
    });

    test('RecurringTask should be a subtype of Task', () {
      const recurringTask = RecurringTask(id: '2', title: 'Weekly', interval: '7 days');
      
      expect(recurringTask, isA<Task>());
    });
  });
}