import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../providers/theme_provider.dart';

class AvailableDaysWidget extends StatelessWidget {
  AvailableDaysWidget({super.key, required this.date, required this.slots, required this.onTap, this.isSelected = false,});
  String date;
  String slots;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140.w,
        decoration: BoxDecoration(
            color: isSelected
                ? themeProvider.isLightTheme() ? ColorsManager.fadedBlue3 : ColorsManager.lightBlue2
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.r)
        ),
        child: Padding(
          padding: REdgeInsets.all(4),
          child: Column(
            children: [
              Text(date, style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 11.sp,color: ColorsManager.black, fontWeight: FontWeight.w900),),
              Text(slots ,style: Theme.of(context).textTheme.labelSmall?.copyWith(color: ColorsManager.blue, fontWeight: FontWeight.w700),)
            ],
          ),
        ),
      ),
    );
  }
}
