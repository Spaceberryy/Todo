import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/task_tile.dart';
import '../widgets/app_drawer.dart';
import 'task_edit_screen.dart';
import 'urgent_and_important_tasks_screen.dart';

class TasksListScreen extends StatefulWidget {
  const TasksListScreen({super.key});

  @override
  State<TasksListScreen> createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TasksProvider>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text('All Tasks'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => context.read<AuthProvider>().signOut(),
            ),
          ],
      ),
      drawer: AppDrawer(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => UrgentAndImportantTasksScreen()),
        ),
      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TaskEditScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
