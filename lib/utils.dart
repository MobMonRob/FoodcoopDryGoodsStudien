import 'package:flutter/material.dart';

Color color1 = const Color.fromRGBO(5, 22, 26, 1);
Color color2 = const Color.fromRGBO(7, 46, 51, 1);
Color color3 = const Color.fromRGBO(12, 112, 117, 1);
Color color4 = const Color.fromRGBO(15, 150, 156, 1);
Color color5 = const Color.fromRGBO(109, 165, 192, 0.15);
Color color5high = const Color.fromRGBO(109, 165, 192, 1);
Color color6 = const Color.fromRGBO(41, 77, 97, 1);

ColorScheme customColorScheme() {
  return ColorScheme(
    primary: color3, // Set the primary variant color
    secondary: color4, // Set the secondary variant color
    surface: color5, // Set the surface color
    background: color5, // Set the background color
    error: Colors.red, // Set the error color
    onPrimary: color2, // Set the color for text/icons on primary color
    onSecondary: Colors.white, // Set the color for text/icons on secondary color
    onSurface: color1, // Set the color for text/icons on surface color
    onBackground: Colors.black, // Set the color for text/icons on background color
    onError: Colors.white, // Set the color for text/icons on error color
    brightness: Brightness.light, // Set the brightness (light or dark)
  );
}

ThemeData customTheme = ThemeData(
  primaryColor: color3,
  colorScheme: customColorScheme(),
  hintColor: color1,
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 17.5,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
        fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
    ),
    displayLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
    ),
    displayMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
    ),
    displaySmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    headlineLarge: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.shifting,
    backgroundColor: color3, // Background color of the navigation bar item
    selectedItemColor: color5high, // Color of the selected item
    unselectedItemColor: color1, // Color of unselected items
    selectedLabelStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal
    ),
    unselectedLabelStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal
    ),
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
);
