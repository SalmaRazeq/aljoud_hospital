import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    cardColor: ColorsManager.lightGray,

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

    bottomSheetTheme: BottomSheetThemeData(

      elevation: 12,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      backgroundColor: ColorsManager.lightBlue.withOpacity(0.7),
    ),
  );



  static final ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsManager.darkBlue,
      primary: ColorsManager.white,
      onPrimary: ColorsManager.blue2,
      shadow: ColorsManager.hint,
      onSecondary: ColorsManager.lightGray,
      secondary: ColorsManager.darkGreen,
      onPrimaryFixed: ColorsManager.blue3,
      onSecondaryFixed: ColorsManager.darkBlue,
      primaryFixed: ColorsManager.white,

    ),

    scaffoldBackgroundColor: ColorsManager.darkBlue,

    dividerColor: ColorsManager.white,

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.darkBlue1,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)))
    ),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.sansita(fontSize: 34,
          fontWeight: FontWeight.w600, color: ColorsManager.white),
      titleMedium: GoogleFonts.poppins(fontSize: 14,
          fontWeight: FontWeight.w500, color: ColorsManager.lightGray),
      displaySmall: GoogleFonts.poppins(fontSize: 12, //text field hint and forgerP
          fontWeight: FontWeight.w400, color: ColorsManager.hint),
      bodySmall: GoogleFonts.sourceSerif4(fontSize: 15,
        fontWeight: FontWeight.w700, color: ColorsManager.white,),
      bodyMedium: GoogleFonts.sourceSerif4(fontSize: 18,
          fontWeight: FontWeight.w600, color: ColorsManager.white),
      bodyLarge: GoogleFonts.inter(fontSize: 18,
          fontWeight: FontWeight.w600, color: ColorsManager.white),
      labelSmall:  GoogleFonts.sourceSans3(fontSize: 10,
        fontWeight: FontWeight.w500, color: ColorsManager.black,),
      labelMedium: GoogleFonts.poppins(fontSize: 12,
        fontWeight: FontWeight.w500, color: ColorsManager.hint,),
    ),

    cardColor: ColorsManager.lightGray,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:  ColorsManager.darkGray.withOpacity(0.2),
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: ColorsManager.lightGray.withOpacity(0.8),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: GoogleFonts.inter(fontSize: 13,
          fontWeight: FontWeight.w600, color: ColorsManager.darkGray),
      unselectedLabelStyle: GoogleFonts.inter(fontSize: 12,
          fontWeight: FontWeight.w600, color: ColorsManager.darkGray),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      elevation: 12,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      backgroundColor: ColorsManager.lightBlue.withOpacity(0.7),
    ),
  );
}
