import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_list_screen.dart';
import 'task_edit_screen.dart';
import '../models/task.dart';
import '../widgets/app_drawer.dart';
import '../widgets/task_tile.dart';

class CategoriesScreen extends StatefulWidget {

  const CategoriesScreen({super.key});

  @override 
  State<CategoriesScreen> createState() => _CategoriesScreen();
}

class _CategoriesScreen extends State<CategoriesScreen> {


  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      backgroundColor: Colors.blueGrey,
      body: tasksProvider.tasks.isEmpty
          ? const Center(child: Text('No tasks yet.'))
          : ListView.builder(
              itemCount: tasksProvider.tasks.length,
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
