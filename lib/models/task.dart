import 'dart:convert';

class Task {
  final String id;
  final String content;
  final String urgency;

  Task({required this.id, required this.content, required this.urgency});

  Map<String, dynamic> toMap() => {
    'id': id,
    'content': content,
    'urgency': urgency,
  };

  factory Task.fromMap(Map<String, dynamic> map) =>
      Task(id: map['id'], content: map['content'], urgency: map['urgency']);

  static List<Task> decode(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map<Task>((task) => Task.fromMap(task))
          .toList();

  static String encode(List<Task> tasks) => json.encode(
    tasks.map<Map<String, dynamic>>((task) => task.toMap()).toList(),
  );
}
