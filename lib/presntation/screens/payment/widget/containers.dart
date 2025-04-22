import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildContainer extends StatelessWidget {
  final String label;
  final String value;
  final String iconPath;
  final String groupValue;
  final Function(String?) onChanged;

  const BuildContainer({
    super.key,
    required this.label,
    required this.value,
    required this.iconPath,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.symmetric(vertical: 6.h),
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: ColorsManager.darkGray, width: value == groupValue ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24.w, height: 24.h),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primaryFixed, fontSize: 16
                ),
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: ColorsManager.darkGray,
            ),
          ],
        ),
      ),
    );
  }
}
