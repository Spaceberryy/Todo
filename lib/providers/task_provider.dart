import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task.dart';
import '../storage/tasks_storage.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final TasksStorage _storage = TasksStorage();
  String? _userId;
  bool _isLoading = false;

  List<Task> get tasks => List.unmodifiable(_tasks);
  bool get isLoading => _isLoading;

  TasksProvider() {
    _initializeUser();
  }

  void _initializeUser() {
    _userId = Supabase.instance.client.auth.currentUser?.id;
  }

  Future<void> loadTasks() async {
    if (_userId == null) return;
    try {
      _isLoading = true;
      notifyListeners();
      _tasks = await _storage.getTasks(_userId!);
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(String content, String urgency) async {
    if (_userId == null) return;
    try {
      await _storage.addTask(_userId!, content, urgency);
      await loadTasks(); // Refresh from server
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask(
      String id,
      String newContent,
      String newUrgency,
      ) async {
    try {
      await _storage.updateTask(id, newContent, newUrgency);
      await loadTasks(); // Refresh from server
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _storage.deleteTask(id);
      await loadTasks(); // Refresh from server
    } catch (e) {
      rethrow;
    }
  }
}