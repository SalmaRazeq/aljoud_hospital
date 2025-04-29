import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailsWidget extends StatelessWidget {
  final String age;
  final String height;
  final String weight;

  const ProfileDetailsWidget({
    super.key,
    this.age = '',   // القيمة الافتراضية فارغة
    this.height = '', // القيمة الافتراضية فارغة
    this.weight = '', // القيمة الافتراضية فارغة
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        color: ColorsManager.fadedBlue3,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDetailItem(context, title: 'Age', value: age.isEmpty ? '--' : age),
          _verticalDivider(),
          _buildDetailItem(context, title: 'Height', value: height.isEmpty ? '--' : height),
          _verticalDivider(),
          _buildDetailItem(context, title: 'Weight', value: weight.isEmpty ? '--' : weight),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, {required String title, required String value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.primaryFixed,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primaryFixed,
              fontWeight: FontWeight.w400, fontSize: 11.sp
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 40.h,
      width: 1.w,
      color: ColorsManager.darkGray,
    );
  }
}
