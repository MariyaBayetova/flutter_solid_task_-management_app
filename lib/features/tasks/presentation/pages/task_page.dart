// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/di/injection.dart';
// import '../bloc/task_bloc.dart';
// import '../bloc/task_event.dart';
// import '../bloc/task_state.dart';

// class TaskPage extends StatelessWidget {
//   const TaskPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => getIt<TaskBloc>()..add(LoadTasksEvent()),
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF3F4F6),
//         appBar: AppBar(
//           elevation: 0,
//           title: const Text(
//             "Task Management",
//             style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.deepPurple,
//           foregroundColor: Colors.white,
//         ),
//         body: BlocBuilder<TaskBloc, TaskState>(
//           builder: (context, state) {
//             if (state is TaskLoading) {
//               return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
//             }

//             if (state is TaskError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
//                     const SizedBox(height: 16),
//                     Text(state.message, style: const TextStyle(color: Colors.redAccent, fontSize: 16)),
//                     TextButton(
//                       onPressed: () => context.read<TaskBloc>().add(LoadTasksEvent()),
//                       child: const Text("Retry"),
//                     )
//                   ],
//                 ),
//               );
//             }

//             if (state is TaskLoaded) {
//               if (state.tasks.isEmpty) {
//                 return const Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("😴", style: TextStyle(fontSize: 60)),
//                       SizedBox(height: 16),
//                       Text(
//                         "No tasks yet\nPress + to add one!",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               return ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                 itemCount: state.tasks.length,
//                 itemBuilder: (context, i) {
//                   final task = state.tasks[i];

//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                       leading: CircleAvatar(
//                         backgroundColor: Colors.deepPurple.withOpacity(0.1),
//                         child: const Icon(Icons.assignment_outlined, color: Colors.deepPurple),
//                       ),
//                       title: Text(
//                         task.title,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF2D3142),
//                         ),
//                       ),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
//                         onPressed: () => _confirmDelete(context, task.id),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }

//             return const SizedBox();
//           },
//         ),
//         floatingActionButton: Builder(
//           builder: (context) => FloatingActionButton.extended(
//             onPressed: () => _showAddDialog(context),
//             backgroundColor: Colors.deepPurple,
//             label: const Text("Add Task", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//             icon: const Icon(Icons.add, color: Colors.white),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showAddDialog(BuildContext context) {
//     final taskBloc = context.read<TaskBloc>();
//     final controller = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (dialogContext) => BlocProvider.value(
//         value: taskBloc,
//         child: AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//           title: const Text("New Task", style: TextStyle(fontWeight: FontWeight.bold)),
//           content: TextField(
//             controller: controller,
//             autofocus: true,
//             decoration: InputDecoration(
//               hintText: "What needs to be done?",
//               filled: true,
//               fillColor: Colors.grey[100],
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
//               onPressed: () => Navigator.pop(dialogContext),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.deepPurple,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               child: const Text("Create"),
//               onPressed: () {
//                 if (controller.text.trim().isNotEmpty) {
//                   taskBloc.add(AddTaskEvent(controller.text.trim()));
//                 }
//                 Navigator.pop(dialogContext);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _confirmDelete(BuildContext context, String id) {
//     final taskBloc = context.read<TaskBloc>();

//     showDialog(
//       context: context,
//       builder: (dialogContext) => BlocProvider.value(
//         value: taskBloc,
//         child: AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//           title: const Text("Delete Task?"),
//           content: const Text("This action cannot be undone."),
//           actions: [
//             TextButton(
//               child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
//               onPressed: () => Navigator.pop(dialogContext),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.redAccent,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               child: const Text("Delete"),
//               onPressed: () {
//                 taskBloc.add(DeleteTaskEvent(id));
//                 Navigator.pop(dialogContext);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TaskBloc>()..add(LoadTasksEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Task Management",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
            }

            if (state is TaskError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
                    const SizedBox(height: 16),
                    Text(state.message, style: const TextStyle(color: Colors.redAccent, fontSize: 16)),
                    TextButton(
                      onPressed: () => context.read<TaskBloc>().add(LoadTasksEvent()),
                      child: const Text("Retry"),
                    )
                  ],
                ),
              );
            }

            if (state is TaskLoaded) {
              if (state.tasks.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("😴", style: TextStyle(fontSize: 60)),
                      SizedBox(height: 16),
                      Text(
                        "No tasks yet\nPress + to add one!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: state.tasks.length,
                itemBuilder: (context, i) {
                  final task = state.tasks[i];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple.withOpacity(0.1),
                        child: const Icon(Icons.assignment_outlined, color: Colors.deepPurple),
                      ),
                      title: Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () => _confirmDelete(context, task.id),
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton.extended(
            onPressed: () => _showAddDialog(context),
            backgroundColor: Colors.deepPurple,
            label: const Text("Add Task", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            icon: const Icon(Icons.add, color: Colors.white),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final taskBloc = context.read<TaskBloc>();
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: taskBloc,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text("New Task", style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "What needs to be done?",
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Create"),
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  taskBloc.add(AddTaskEvent(controller.text.trim()));
                }
                Navigator.pop(dialogContext);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    final taskBloc = context.read<TaskBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: taskBloc,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text("Delete Task?"),
          content: const Text("This action cannot be undone."),
          actions: [
            TextButton(
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Delete"),
              onPressed: () {
                taskBloc.add(DeleteTaskEvent(id));
                Navigator.pop(dialogContext);
              },
            ),
          ],
        ),
      ),
    );
  }
}