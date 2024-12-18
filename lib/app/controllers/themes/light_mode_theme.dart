import 'package:flutter/material.dart';

/// A class that defines the light mode theme for the application.
/// 
/// This theme customizes various aspects of the UI, such as colors for
/// primary and secondary elements, app bar, cards, and buttons.
class LightModeTheme {
  /// Returns the [ThemeData] for light mode, with customizations applied.
  ThemeData get theme {
    return ThemeData.light().copyWith(
      colorScheme: const ColorScheme.light(
        primary: Colors.blue, // Primary color for the theme
        secondary: Colors.amber, // Secondary color for the theme
        onPrimary: Colors.black, // Color for text/icons on primary color
        onSecondary: Colors.white, // Color for text/icons on secondary color
        // Add more color customizations as needed
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue[800], // Background color for app bar
        foregroundColor: Colors.white, // Text/icon color for app bar
      ),
      cardTheme: CardTheme(
        color: Colors.white, // Background color for cards
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners for cards
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Background color for buttons
          foregroundColor: Colors.white, // Text color for buttons
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding for buttons
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners for buttons
          ),
        ),
      ),
      // Add more theme customizations as needed
    );
  }
}