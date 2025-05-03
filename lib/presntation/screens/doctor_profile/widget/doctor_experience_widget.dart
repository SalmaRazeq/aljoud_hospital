import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class DoctorExperienceWidget extends StatelessWidget {
  DoctorExperienceWidget({required this.text, required this.icon,super.key});
  IconData icon;
  String text;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: REdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        width: 90.w,
        height: 100.h,
        padding: REdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color:  themeProvider.isLightTheme() ? ColorsManager.lightBlue : ColorsManager.blue3.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(icon, color: themeProvider.isLightTheme() ? ColorsManager.blue2 : ColorsManager.darkBlue1, size: 30.sp,),
              SizedBox(height: 4.h,),
              Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11.sp),
                maxLines: 2,textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}
