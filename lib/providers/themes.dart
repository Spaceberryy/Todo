import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = yellowTheme;

  ThemeData get currentTheme => _currentTheme;

  ThemeNotifier() {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('theme') ?? 'yellow';

    _currentTheme = _themeFromString(themeName);
    notifyListeners();
  }

  void setTheme(String themeName) async {
    _currentTheme = _themeFromString(themeName);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', themeName);
  }

  ThemeData _themeFromString(String name) {
    switch (name) {
      case 'pink':
        return pinkTheme;
      case 'blue':
        return blueTheme;
      case 'grey':
        return greyTheme;
      case 'dark':
        return darkTheme;
      default:
        return yellowTheme;
    }
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
  colorScheme: ColorScheme.light(
    primary: Color(0xFFF9A825),
    surface: Color(0xFFFFFDE7),
    onSurface: Color(0xFF1A1400),
    outline: Color(0xFFFFE082),
  ),
);

final blueTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.blue[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue[200],
    foregroundColor: Colors.black,
  ),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.blue[100]),
  colorScheme: ColorScheme.light(
    primary: Color(0xFF1E88E5),       // blue accent
    surface: Color(0xFFE3F2FD),       // light blue background
    onSurface: Color(0xFF0D1B2A),     // dark text
    outline: Color(0xFF90CAF9),       // border color
  ),
);

final pinkTheme = ThemeData(
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: Colors.pink[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.pink[200],
    foregroundColor: Colors.black,
  ),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.pink[100]),
  colorScheme: ColorScheme.light(
    primary: Color(0xFFE91E8C),
    surface: Color(0xFFFCE4EC),
    onSurface: Color(0xFF1A0010),
    outline: Color(0xFFF48FB1),
  ),
);
final greyTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.blueGrey[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueGrey[200],
    foregroundColor: Colors.black,
  ),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.blueGrey[100]),
  colorScheme: ColorScheme.light(
    primary: Colors.blueGrey[700]!,
    surface: Colors.blueGrey[50]!,
    onSurface: Colors.black87,
    outline: Colors.blueGrey[300]!,
  ),
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
  colorScheme: ColorScheme.dark(
    primary: Colors.grey[400]!,
    surface: Colors.grey[800]!,  // use Color(0xFF1E1E1E) if 850 gives an error
    onSurface: Colors.grey[200]!,
    outline: Colors.grey[600]!,
  ),
);
