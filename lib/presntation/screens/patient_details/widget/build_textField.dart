import 'package:aljoud_hospital/presntation/screens/auth/widget/field_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../providers/theme_provider.dart';

class BuildTextField extends StatelessWidget {
  BuildTextField({required this.icon, required this.hintText,required this.controller, required this.validator,
    this.keyBoardType = TextInputType.text, super.key});
  String hintText;
  IconData icon;
  TextEditingController controller;
  Validator validator;
  TextInputType keyBoardType;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return TextFormField(
        autofocus: true,
        validator: validator,
        keyboardType: keyBoardType,
        controller: controller,
      style: GoogleFonts.inter(fontSize: 15.sp, color: ColorsManager.black),
      decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: GoogleFonts.roboto(fontSize: 13.sp,color: themeProvider.isLightTheme() ? ColorsManager.lightGray : ColorsManager.hint),
          suffixIcon: Icon(
            icon, color: themeProvider.isLightTheme() ? ColorsManager.lightGray : ColorsManager.hint, size: 22.sp,),
          errorStyle: GoogleFonts.roboto(fontSize: 10.sp,fontWeight: FontWeight.w500),
          filled: true,
          fillColor: ColorsManager.white,
          contentPadding: REdgeInsets.symmetric(vertical: 9.h, horizontal: 12.w),
          constraints: BoxConstraints(
              minHeight: 50.h
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(color: Colors.red,)
          ),
        ),
      );
  }
}
