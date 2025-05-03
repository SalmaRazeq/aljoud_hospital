import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonDesign extends StatelessWidget {
  ElevatedButtonDesign({super.key, required this.text, required this.onTap});
  VoidCallback onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall?.
            copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary)
        ),
      ),
    );
  }
}
