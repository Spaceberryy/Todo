import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_edit_screen.dart';
import '../widgets/task_tile.dart';

class UrgentAndImportantTasksScreen extends StatefulWidget {

  const UrgentAndImportantTasksScreen({super.key});

  @override 
  State<UrgentAndImportantTasksScreen> createState() => _UrgentAndImportantTasksScreen();
}

class _UrgentAndImportantTasksScreen extends State<UrgentAndImportantTasksScreen> {

  String urgency = 'Urgent and Important';

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final filteredTasks = tasksProvider.tasks.where((task) => task.urgency == urgency).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Urgent and Important')),
      backgroundColor: Colors.blueGrey,
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
