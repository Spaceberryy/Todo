import 'package:flutter/material.dart';
import 'package:todoapp/screens/not_urgent_and_not_important_tasks_screen.dart';
import 'package:todoapp/screens/not_urgent_but_important_tasks_screen.dart';
import '../screens/all_tasks_screen.dart';
import '../screens/urgent_and_important_tasks_screen.dart';
import '../screens/urgent_but_not_important_tasks_screen.dart';
import '../screens/settings_screen.dart';

class AppDrawer extends StatefulWidget {
  final VoidCallback? onTap;

  const AppDrawer({super.key, required this.onTap});

  @override
  State<AppDrawer> createState() => _AppDrawer();
}

class _AppDrawer extends State<AppDrawer> {
  static List<String> urgencies = [
    'All Tasks',
    'Urgent and Important',
    'Urgent but not Important',
    'Not Urgent but Important',
    'Not Urgent and Not Important',
  ];

  String? selectedCategory = urgencies.first;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const ListTile(
            title: Text(
              "Todo",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          ListTile(
            title: const Text("Select Category"),
            subtitle: DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              items: urgencies
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                if (value == urgencies[0]) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TasksListScreen()),
                  );
                } else if (value == urgencies[1]) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UrgentAndImportantTasksScreen(),
                    ),
                  );
                } else if (value == urgencies[2]) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UrgentButNotImportantTasksScreen(),
                    ),
                  );
                } else if (value == urgencies[3]) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NotUrgentButImportantTasksScreen(),
                    ),
                  );
                } else if (value == urgencies[4]) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NotUrgentAndNotImportantTasksScreen(),
                    ),
                  );
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
