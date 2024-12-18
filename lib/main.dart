import 'package:expense_tracker_2/app/controllers/themes/dark_mode_theme.dart';
import 'package:expense_tracker_2/app/controllers/themes/light_mode_theme.dart';
import 'package:expense_tracker_2/app/view/expense.dart';
import 'package:flutter/material.dart';

/// The entry point of the application.
/// 
/// This function initializes the app by running the [MyApp] widget.
void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
/// 
/// This widget sets up the [MaterialApp] with theming and the home page.
class MyApp extends StatelessWidget {
  /// Creates an instance of [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker', // The title of the application
      theme: LightModeTheme().theme, // The theme for light mode
      darkTheme: DarkModeTheme().theme, // The theme for dark mode
      themeMode: ThemeMode.system, // Automatically switch between light and dark themes based on system settings
      home: const Expenses(), // The home page of the application
    );
  }
}