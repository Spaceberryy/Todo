import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TaskTile({super.key, required this.task, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.content),
      subtitle: Text(task.urgency),
      onTap: onTap,
      trailing: IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
    );
  }
}
