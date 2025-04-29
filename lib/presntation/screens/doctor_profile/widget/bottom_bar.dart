import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: REdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 35.h,
        padding: REdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: ColorsManager.fadedBlue3,
          borderRadius: BorderRadius.circular(5.r)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.phone_outlined, size: 22.sp,),
            SizedBox(width: 15.w,),
            Directionality(
              textDirection: TextDirection.ltr,
                child: Text(Localizations.localeOf(context).languageCode == 'ar'
                    ? '( 2:00 pm - 3:00 pm)  ${loc.voiceCall}'
                    : '${loc.voiceCall} ( 2:00 pm - 3:00 pm)',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 13.sp,color: ColorsManager.black),)),
            SizedBox(width: 28.w,),
          ],
        ),
      ),
    );
  }
}
