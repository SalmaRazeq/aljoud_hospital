import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsManager.white,
      primary: ColorsManager.white,
      onPrimary: ColorsManager.blue2,
      shadow: ColorsManager.hint,
      onSecondary: ColorsManager.darkGray,
      secondary: ColorsManager.lightGreen,
      onPrimaryFixed: ColorsManager.blue3,
      onSecondaryFixed: ColorsManager.blue,
      primaryFixed: ColorsManager.black,

    ),

      scaffoldBackgroundColor: ColorsManager.white,

      dividerColor: ColorsManager.black,

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.blue2,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)))
      ),

      textTheme: TextTheme(
        titleLarge: GoogleFonts.sansita(fontSize: 34,
            fontWeight: FontWeight.w600, color: ColorsManager.black),
        titleMedium: GoogleFonts.poppins(fontSize: 14,
            fontWeight: FontWeight.w500, color: ColorsManager.darkGray),
        displaySmall: GoogleFonts.poppins(fontSize: 12, //text field hint and forgerP
            fontWeight: FontWeight.w400, color: ColorsManager.hint),
        bodySmall: GoogleFonts.sourceSerif4(fontSize: 15,
          fontWeight: FontWeight.w700, color: ColorsManager.black,),
        bodyMedium: GoogleFonts.sourceSerif4(fontSize: 18,
            fontWeight: FontWeight.w600, color: ColorsManager.white),
        bodyLarge: GoogleFonts.inter(fontSize: 18,
            fontWeight: FontWeight.w600, color: ColorsManager.black),
        labelSmall:  GoogleFonts.sourceSans3(fontSize: 10,
          fontWeight: FontWeight.w500, color: ColorsManager.darkGray,),
        labelMedium: GoogleFonts.poppins(fontSize: 12,
          fontWeight: FontWeight.w500, color: ColorsManager.hint,),
      ),

    cardColor: ColorsManager.beige,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFFF2F0EF),
      selectedItemColor: ColorsManager.blue2,
      unselectedItemColor: ColorsManager.hint,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: GoogleFonts.inter(fontSize: 13,
          fontWeight: FontWeight.w600, color: ColorsManager.darkGray),
      unselectedLabelStyle: GoogleFonts.inter(fontSize: 12,
          fontWeight: FontWeight.w600, color: ColorsManager.darkGray),

    ),
  );
}
