import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_edit_screen.dart';
import '../widgets/task_tile.dart';

class NotUrgentButImportantTasksScreen extends StatefulWidget {
  const NotUrgentButImportantTasksScreen({super.key});

  @override
  State<NotUrgentButImportantTasksScreen> createState() =>
      _NotUrgentButImportantTasksScreen();
}

class _NotUrgentButImportantTasksScreen
    extends State<NotUrgentButImportantTasksScreen> {
  String urgency = 'Not Urgent but Important';

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final filteredTasks = tasksProvider.tasks
        .where((task) => task.urgency == urgency)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Not Urgent but Important')),
      body: tasksProvider.tasks.isEmpty
          ? const Center(child: Text('No tasks yet.'))
          : ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, idx) {
                final task = filteredTasks[idx];
                return TaskTile(
                  task: task,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TaskEditScreen(task: task),
                    ),
                  ),
                  onDelete: () async {
                    await tasksProvider.deleteTask(task.id);
                  },
                );
              },
            ),
    );
  }
}
