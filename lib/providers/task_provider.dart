import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../storage/tasks_storage.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final TasksStorage _storage = TasksStorage();

  List<Task> get tasks => List.unmodifiable(_tasks);

  Future<void> loadTasks() async {
    _tasks = await _storage.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String content, String urgency) async {
    final newTask = Task(
      id: const Uuid().v4(),
      content: content,
      urgency: urgency,
    );
    _tasks.add(newTask);
    await _storage.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> updateTask(
    String id,
    String newContent,
    String newUrgency,
  ) async {
    final idx = _tasks.indexWhere((n) => n.id == id);
    if (idx != -1) {
      _tasks[idx] = Task(id: id, content: newContent, urgency: newUrgency);
      await _storage.saveTasks(_tasks);
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((n) => n.id == id);
    await _storage.saveTasks(_tasks);
    notifyListeners();
  }
}
