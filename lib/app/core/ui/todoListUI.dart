import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUI {

  TodoListUI._();

  static ThemeData get theme => ThemeData(
    primaryColor: const Color.fromARGB(255, 182, 12, 12),
    primaryColorLight: const Color.fromARGB(255, 184, 166, 3),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 80, 2, 182),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 15.0),

        ),
    ),
    textTheme: GoogleFonts.kufamTextTheme(),
);






}