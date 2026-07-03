import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';

class TasksStorage {
  final _supabase = Supabase.instance.client;

  Future<List<Task>> getTasks(String userId) async {
    try {
      final response = await _supabase
          .from('tasks')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Task.fromMap(json))
          .toList();
    } catch (e) {
      throw 'Failed to load tasks: $e';
    }
  }

  Future<void> addTask(String userId, String content, String urgency) async {
    try {
      await _supabase.from('tasks').insert({
        'id': const Uuid().v4(),
        'user_id': userId,
        'content': content,
        'urgency': urgency,
      });
    } catch (e) {
      throw 'Failed to load task: $e';
    }
  }

  Future<void> updateTask(
      String id,
      String newContent,
      String newUrgency
      ) async {
    try {
      await _supabase.from('tasks').update({
        'content': newContent,
        'urgency': newUrgency,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', id);
    } catch (e) {
      throw 'Failed to update task: $e';
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _supabase.from('tasks').delete().eq('id', id);
    } catch (e) {
      throw 'Failed to delete task: $e';
    }
  }
}