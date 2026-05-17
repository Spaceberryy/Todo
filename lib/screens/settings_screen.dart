import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/themes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Yellow'),
            onTap: () => themeNotifier.setTheme(yellowTheme),
          ),
          ListTile(
            title: const Text('Blue'),
            onTap: () => themeNotifier.setTheme(blueTheme),
          ),
          ListTile(
            title: const Text('Pink'),
            onTap: () => themeNotifier.setTheme(pinkTheme),
          ),
          ListTile(
            title: const Text('Grey'),
            onTap: () => themeNotifier.setTheme(greyTheme),
          ),
          ListTile(
            title: const Text('Dark'),
            onTap: () => themeNotifier.setTheme(darkTheme),
          ),
        ],
      ),
    );
  }
}
