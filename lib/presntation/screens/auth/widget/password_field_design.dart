import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

typedef Validator = String? Function(String?);

class PasswordFieldDesign extends StatefulWidget {
  PasswordFieldDesign({super.key,  required this.hintText,
    required this.controller, required this.validator, this.keyBoardType = TextInputType.text});
  String hintText;
  TextEditingController controller;
  Validator validator;
  TextInputType keyBoardType;

  @override
  State<PasswordFieldDesign> createState() => _PasswordFieldDesignState();
}

class _PasswordFieldDesignState extends State<PasswordFieldDesign> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      validator: widget.validator,
      obscureText: obscureText,
      keyboardType: widget.keyBoardType,
      controller: widget.controller, style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.roboto(fontSize: 12.sp,color: Theme.of(context).colorScheme.shadow),
        filled: true,
        fillColor: ColorsManager.textField,
        errorStyle: GoogleFonts.roboto(fontSize: 9.sp, fontWeight: FontWeight.w400),
        contentPadding: REdgeInsets.symmetric(vertical: 9, horizontal: 12),
        constraints: BoxConstraints(
          minHeight: 50.h
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility, color: ColorsManager.darkGray, size: 16,
          ),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
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
