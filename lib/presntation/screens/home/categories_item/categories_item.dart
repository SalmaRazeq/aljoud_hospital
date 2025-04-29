import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesItem extends StatelessWidget {
  CategoriesItem({super.key, required this.imagePath, required this.title});
  String imagePath;
  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 90.w,
          height: 90.h,
        ),
        SizedBox(height: 4.h,),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 10.5.sp,),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
