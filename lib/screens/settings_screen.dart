import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/themes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Yellow'),
            onTap: () => themeNotifier.setTheme("yellow"),
          ),
          ListTile(
            title: const Text('Blue'),
            onTap: () => themeNotifier.setTheme("blue"),
          ),
          ListTile(
            title: const Text('Pink'),
            onTap: () => themeNotifier.setTheme("pink"),
          ),
          ListTile(
            title: const Text('Grey'),
            onTap: () => themeNotifier.setTheme("grey"),
          ),
          ListTile(
            title: const Text('Dark'),
            onTap: () => themeNotifier.setTheme("dark"),
          ),
        ],
      ),
    );
  }
}
