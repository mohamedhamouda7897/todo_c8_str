import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_c8_str/shared/styles/app_colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: lightGreenColor,
      primaryColor: lightColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: lightColor,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: GoogleFonts.elMessiri(),
          unselectedLabelStyle: GoogleFonts.elMessiri()),
      textTheme: TextTheme(
          bodySmall: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.bold, color: lightColor),
          bodyMedium: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.normal, color: fontColor),
          bodyLarge: GoogleFonts.poppins(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Color(0xFFffffff)),
        backgroundColor: lightColor,
      ));
  static ThemeData darkTheme = ThemeData();
}
