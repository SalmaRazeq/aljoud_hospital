import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

typedef Validator = String? Function(String?);


class RegisterDesign extends StatelessWidget {
  RegisterDesign({super.key, required this.hintText,
    required this.controller, required this.validator, this.isSecure = false, this.keyBoardType = TextInputType.text});
  String hintText;
  TextEditingController controller;
  Validator validator;
  bool isSecure;
  TextInputType keyBoardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        autofocus: true,
        validator: validator,
        obscureText: isSecure,
        keyboardType: keyBoardType,
        controller: controller, style: TextStyle(fontSize: 16.sp),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: GoogleFonts.roboto(fontSize: 16.sp,color: Theme.of(context).colorScheme.shadow),
          filled: true,
          fillColor: ColorsManager.textField,
          errorStyle: GoogleFonts.roboto(fontSize: 12.sp,),
          constraints: BoxConstraints(
            minHeight: 60.h,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.red,)
          ),
        ),
      ),
    );
  }
}
