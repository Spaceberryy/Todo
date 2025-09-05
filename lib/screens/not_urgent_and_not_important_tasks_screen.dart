import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_edit_screen.dart';
import '../widgets/task_tile.dart';

class NotUrgentAndNotImportantTasksScreen extends StatefulWidget {

  const NotUrgentAndNotImportantTasksScreen({super.key});

  @override 
  State<NotUrgentAndNotImportantTasksScreen> createState() => _NotUrgentAndNotImportantTasksScreen();
}

class _NotUrgentAndNotImportantTasksScreen extends State<NotUrgentAndNotImportantTasksScreen> {

  String urgency = 'Not Urgent and Not Important';

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final filteredTasks = tasksProvider.tasks.where((task) => task.urgency == urgency).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Not Urgent and Not Important')),
      backgroundColor: Colors.blueGrey,
      body: tasksProvider.tasks.isEmpty
          ? const Center(child: Text('No tasks yet.'))
          : ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, idx) {
                final task = tasksProvider.tasks[idx];
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
