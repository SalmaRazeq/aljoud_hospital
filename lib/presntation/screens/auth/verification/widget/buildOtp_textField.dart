import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/color_manager.dart';

class BuildOtpTextField extends StatelessWidget {
  BuildOtpTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.onCompleted,
    this.previousFocus,
    this.autofocus = true,
  });

  TextEditingController? controller;
  FocusNode? focusNode;
  FocusNode? nextFocus;
  FocusNode? previousFocus;
  VoidCallback? onCompleted;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      height: 50.h,
      child: TextFormField(
        autofocus: autofocus,
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorsManager.blue2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorsManager.darkGray),
            borderRadius: BorderRadius.circular(10.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.r),
          ),
          filled: true,
          fillColor: ColorsManager.white,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              FocusScope.of(context).unfocus(); // إغلاق الكيبورد بعد آخر مربع
            }
          } else {
            if (previousFocus != null) {
              FocusScope.of(context).requestFocus(previousFocus);
            }
          }
          if (onCompleted != null) {
            onCompleted!();  // استدعاء دالة onCompleted
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';  // رسالة خطأ في حالة عدم إدخال قيمة
          }
          return null;
        },
      ),
    );
  }

}

