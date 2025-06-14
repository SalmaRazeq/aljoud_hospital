import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

typedef Validator = String? Function(String?);


class TextFieldDesign extends StatelessWidget {
  TextFieldDesign({super.key,  required this.hintText,
    required this.controller, required this.validator, this.keyBoardType = TextInputType.text});
  String hintText;
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
      style: GoogleFonts.inter(fontSize: 14.sp, color: ColorsManager.black),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(fontSize: 12.sp,color: Theme.of(context).colorScheme.shadow),
        filled: true,
        fillColor: themeProvider.isLightTheme() ? ColorsManager.textField : ColorsManager.lightGray,
        errorStyle: GoogleFonts.roboto(fontSize: 9.sp,fontWeight: FontWeight.w400),
        contentPadding: REdgeInsets.symmetric(vertical: 11, horizontal: 12),
        constraints: BoxConstraints(
            minHeight: 50.h
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: ColorsManager.hint)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: ColorsManager.hint)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: ColorsManager.darkGray)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: Colors.red,)
        ),
      ),
    );
  }
}
