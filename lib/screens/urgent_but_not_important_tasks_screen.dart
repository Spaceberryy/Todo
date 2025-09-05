import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_edit_screen.dart';
import '../widgets/task_tile.dart';

class UrgentButNotImportantTasksScreen extends StatefulWidget {

  const UrgentButNotImportantTasksScreen({super.key});

  @override 
  State<UrgentButNotImportantTasksScreen> createState() => _UrgentButNotImportantTasksScreen();
}

class _UrgentButNotImportantTasksScreen extends State<UrgentButNotImportantTasksScreen> {

  // reference
  // 'All Tasks',
  // 'Urgent and Important',
  // 'Urgent but not Important',
  // 'Not Urgent but Important',
  // 'Not Urgent and Not Important'
  String urgency = 'Urgent but not Important';

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final filteredTasks = tasksProvider.tasks.where((task) => task.urgency == urgency).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Urgent but Not Important')),
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
