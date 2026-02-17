import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'features/tasks/presentation/pages/task_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies("prod");
  
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task Manager",
      theme: ThemeData.light(),
      home: const TaskPage(),
    );
  }
}