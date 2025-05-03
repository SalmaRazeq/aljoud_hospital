import 'package:aljoud_hospital/presntation/screens/auth/widget/field_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../providers/theme_provider.dart';

class EditprofileTextfield extends StatelessWidget {
  EditprofileTextfield({required this.hintText,required this.controller, required this.validator,
    this.keyBoardType = TextInputType.text, super.key});
  String hintText;
  TextEditingController controller;
  Validator validator;
  TextInputType keyBoardType;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);


    return TextFormField(
      autofocus: false,
      validator: validator,
      keyboardType: keyBoardType,
      controller: controller,
      style: GoogleFonts.inter(fontSize: 14.sp, color: ColorsManager.black),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: GoogleFonts.inter(fontSize: 13.sp,color: ColorsManager.hint),
        errorStyle: GoogleFonts.roboto(fontSize: 10.sp,fontWeight: FontWeight.w500),
        filled: true,
        fillColor: themeProvider.isLightTheme() ? ColorsManager.lightBlue : ColorsManager.lightBlue2,
        contentPadding: REdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        constraints: BoxConstraints(
            minHeight: 50.h
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.red,)
        ),
      ),
    );
  }
}
