import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';

class AvailableDaysWidget extends StatelessWidget {
  AvailableDaysWidget({super.key, required this.date, required this.slots, required this.onTap, this.isSelected = false,});
  String date;
  String slots;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        decoration: BoxDecoration(
            color: isSelected
                ? ColorsManager.fadedBlue3
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.r)
        ),
        child: Padding(
          padding: REdgeInsets.all(4),
          child: Column(
            children: [
              Text(date, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: ColorsManager.black, fontWeight: FontWeight.w900),),
              Text(slots ,style: Theme.of(context).textTheme.labelSmall?.copyWith(color: ColorsManager.blue, fontWeight: FontWeight.w900),)
            ],
          ),
        ),
      ),
    );
  }
}
