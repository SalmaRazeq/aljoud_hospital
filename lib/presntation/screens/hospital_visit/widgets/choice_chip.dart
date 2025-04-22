import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';

class ChoiceChipWidget extends StatefulWidget {
  ChoiceChipWidget({super.key});

  @override
  State<ChoiceChipWidget> createState() => _ChoiceChipWidgetState();
}
String selectedAppointmentType = 'Online';
class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appointment Type',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              ChoiceChip(
                backgroundColor: ColorsManager.beige,
                selectedColor: ColorsManager.fadedBlue3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                labelStyle: Theme.of(context).textTheme.titleMedium?.
                copyWith(fontSize: 12,color: Theme.of(context).colorScheme.primaryFixed),
                label: Text(
                  'Online',
                  style: TextStyle(
                    color: selectedAppointmentType == 'Online'
                        ? ColorsManager.blue
                        : ColorsManager.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                selected: selectedAppointmentType == 'Online',
                onSelected: (val) {
                  setState(() {
                    selectedAppointmentType = 'Online';
                  });
                },
              ),
              SizedBox(width: 8.w),

              ChoiceChip(
                backgroundColor: ColorsManager.beige,
                selectedColor: ColorsManager.fadedBlue3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                label: Text(
                  'In-Person',
                  style: TextStyle(
                    color: selectedAppointmentType == 'In-Person'
                        ? ColorsManager.blue
                        : ColorsManager.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                selected: selectedAppointmentType == 'In-Person',
                onSelected: (val) {
                  setState(() {
                    selectedAppointmentType = 'In-Person';
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
