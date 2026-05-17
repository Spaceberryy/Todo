import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskEditScreen extends StatefulWidget {
  final Task? task;

  const TaskEditScreen({super.key, this.task});

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late TextEditingController _controller;

  static List<String> urgencies = [
    'Urgent and Important',
    'Urgent but not Important',
    'Not Urgent but Important',
    'Not Urgent and Not Important',
  ];

  String? selectedOption;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task?.content ?? '');
    selectedOption = _checkIfTaskExists();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveTask() async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);

    if (widget.task == null) {
      await tasksProvider.addTask(content, selectedOption!);
    } else {
      await tasksProvider.updateTask(widget.task!.id, content, selectedOption!);
    }
    if (context.mounted) Navigator.pop(context);
  }

  String _checkIfTaskExists() {
    if (widget.task != null) {
      return widget.task!.urgency;
    } else {
      return urgencies.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.task != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Task' : 'Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(),
              ),
            ),
            DropdownButton<String>(
              value: selectedOption,
              elevation: 16,
              style: const TextStyle(height: 2, color: Colors.blueGrey),
              onChanged: (String? value) {
                setState(() {
                  selectedOption = value!;
                });
              },
              items: urgencies.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text(isEdit ? 'Save Changes' : 'Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
