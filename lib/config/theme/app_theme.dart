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
      onSecondary: ColorsManager.black2,
      secondary: ColorsManager.lightGreen,
    ),
      scaffoldBackgroundColor: ColorsManager.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.blue2,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)))),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.sansita(fontSize: 35,
            fontWeight: FontWeight.w600, color: ColorsManager.black),
        titleMedium: GoogleFonts.poppins(fontSize: 15,
            fontWeight: FontWeight.w500, color: ColorsManager.black2),
        displaySmall: GoogleFonts.inter(fontSize: 14,
            fontWeight: FontWeight.w400, color: ColorsManager.hint),
        bodyLarge: GoogleFonts.sourceSerif4(fontSize: 20,
          fontWeight: FontWeight.w900, color: ColorsManager.black,),
        bodyMedium: GoogleFonts.sourceSerif4(fontSize: 24.sp,
            fontWeight: FontWeight.w600, color: ColorsManager.white),
      ),
  );
}
