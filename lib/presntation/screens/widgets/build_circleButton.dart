import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildCircleButton extends StatelessWidget {
  BuildCircleButton({required this.icon, required this.onTap,super.key});
   VoidCallback onTap;
   IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30.h,
        width: 30.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryFixed,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.onSecondaryFixed,
            width: 1.w,
          ),
        ),
        child: Icon(icon, size: 20.sp, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
