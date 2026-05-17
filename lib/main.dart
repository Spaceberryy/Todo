import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/task.dart';
import 'providers/task_provider.dart';
import 'providers/themes.dart';
import 'screens/all_tasks_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TasksProvider()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: const Todoapp(),
    ),
  );
}

class Todoapp extends StatelessWidget {
  const Todoapp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Just do it',
        theme: context.watch<ThemeNotifier>().currentTheme,
        home: const TasksListScreen(),
        debugShowCheckedModeBanner: false,
      );
  }
}
