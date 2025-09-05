import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TasksStorage {
  static const String _key = 'tasks';

  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(_key);
    if (tasksString == null) return [];
    return Task.decode(tasksString);
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, Task.encode(tasks));
  }
}
