import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutDoctor extends StatelessWidget {
  AboutDoctor({super.key, required this.title, required this.body, required this.decoration});
  String title;
  String body;
  TextDirection decoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title , style: Theme.of(context).textTheme.bodySmall!.
          copyWith(fontSize: 16.sp)),
          Directionality(
            textDirection: decoration,
              child: Text(body , style: Theme.of(context).textTheme.labelMedium))
        ],
      ),
    );
  }
}
