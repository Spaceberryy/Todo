import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = yellowTheme;

  ThemeData get currentTheme => _currentTheme;

  ThemeNotifier() {
    _loadTheme();
  }

  void setTheme(ThemeData theme) async {
    _currentTheme = theme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'theme',
      theme == yellowTheme
          ? 'yellow'
          : theme == pinkTheme
          ? 'pink'
          : theme == greyTheme
          ? 'grey'
          : theme == blueTheme
          ? 'blue'
          : 'dark',
    );
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('theme') ?? 'yellow';

    if (themeName == 'pink') {
      _currentTheme = pinkTheme;
    } else if (themeName == 'blue') {
      _currentTheme = blueTheme;
    } else if (themeName == 'grey') {
      _currentTheme = greyTheme;
    } else if (themeName == 'dark') {
      _currentTheme = darkTheme;
    } else {
      _currentTheme = yellowTheme;
    }
    notifyListeners();
  }
}

final yellowTheme = ThemeData(
  primarySwatch: Colors.yellow,
  scaffoldBackgroundColor: Colors.yellow[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.yellow[200],
    foregroundColor: Colors.black,
  ),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.yellow[100]),
);

final blueTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.blue[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue[200],
    foregroundColor: Colors.black,
  ),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.blue[100]),
);

final pinkTheme = ThemeData(
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: Colors.pink[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.pink[200],
    foregroundColor: Colors.black,
  ),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.pink[100]),
);
final greyTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.blueGrey[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueGrey[200],
    foregroundColor: Colors.black,
  ),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.blueGrey[100]),
);
final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  scaffoldBackgroundColor: Colors.grey[800],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    foregroundColor: Colors.white,
  ),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[700]),
  listTileTheme: ListTileThemeData(
    textColor: Colors.grey[200],
    // Change text color for ListTiles inside the Drawer
    iconColor: Colors.grey[200], // Change icon color if using icons
  ),
);
