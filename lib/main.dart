import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/auth_provider.dart';
import 'package:todoapp/config/supabase_config.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/screens/login.dart';
import 'providers/task_provider.dart';
import 'providers/themes.dart';
import 'screens/all_tasks_screen.dart';
import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
        title: 'Tudu',
        theme: context.watch<ThemeNotifier>().currentTheme,
        home: Consumer<AuthProvider>(
          builder: (context, auth, _) {
            if (auth.isAuthenticated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<TasksProvider>().loadTasks();
              });
              return const TasksListScreen();
            } else {
              return const LoginScreen();
            }
          }
        ),
        debugShowCheckedModeBanner: false,
      );
  }
}
