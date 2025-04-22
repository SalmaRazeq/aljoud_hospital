import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
        fillColor: ColorsManager.textField,
        errorStyle: GoogleFonts.roboto(fontSize: 10.sp,fontWeight: FontWeight.w500),
        contentPadding: REdgeInsets.symmetric(vertical: 12, horizontal: 10),
        constraints: BoxConstraints(
            minHeight: 50.h
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.red,)
        ),
      ),
    );
  }
}
