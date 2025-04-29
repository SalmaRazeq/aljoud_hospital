import 'package:aljoud_hospital/presntation/screens/auth/widget/field_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/color_manager.dart';

class DoctorTextField extends StatelessWidget {
  DoctorTextField({required this.icon, required this.hintText,required this.controller, required this.validator,
    this.keyBoardType = TextInputType.text, super.key});
  String hintText;
  IconData icon;
  TextEditingController controller;
  Validator validator;
  TextInputType keyBoardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      validator: validator,
      keyboardType: keyBoardType,
      controller: controller, style: TextStyle(fontSize: 14.sp, ),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(fontSize: 12.sp,color: Theme.of(context).colorScheme.shadow),
        filled: true,
        prefixIcon: Icon(icon, size: 24, color: ColorsManager.hint,),
        fillColor: ColorsManager.textField,
        errorStyle: GoogleFonts.roboto(fontSize: 9.sp,fontWeight: FontWeight.w400),
        contentPadding: REdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
