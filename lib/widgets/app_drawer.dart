import 'package:flutter/material.dart';


class AppDrawer extends StatelessWidget {
  final VoidCallback? onTap;

  const AppDrawer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTile(
	title: Text("Categories"), 
	onTap: onTap,
      ),
    );
  }
}

