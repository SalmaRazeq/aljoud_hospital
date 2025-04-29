import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCircleButton extends StatelessWidget {
  ProfileCircleButton({required this.icon, required this.onTap,super.key});
  VoidCallback onTap;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 32.h,
        width: 32.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
          boxShadow: const [
           BoxShadow(
              color: Colors.black38,
              spreadRadius: -2,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, size: 20.sp, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
