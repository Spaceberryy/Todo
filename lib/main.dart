import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/all_tasks_screen.dart';

void main() {
  runApp(const todoapp());
}

class todoapp extends StatelessWidget {
  const todoapp({super.key});

  @override 
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TasksProvider(),
      child: MaterialApp(
	title: 'Just do it',
	theme: ThemeData(primarySwatch: Colors.blueGrey),
	home: const TasksListScreen(),
	debugShowCheckedModeBanner: false,
      ),
    );
  }
}
