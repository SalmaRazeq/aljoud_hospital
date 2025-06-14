import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/presntation/screens/home/home_tab/about_hospital/vision_mission_widget/vision_mission_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../l10n/app_localizations.dart';

class AboutHospitalScreen extends StatelessWidget {
  const AboutHospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.only(
                top: 10.h, bottom: 30.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).colorScheme.primaryFixed,
                        size: 22.sp,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          loc.aboutHospital,
                          style: GoogleFonts.inter(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primaryFixed,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 35.w,
                    )
                  ],
                ),
                SizedBox(height: 6.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    AssetsManager.hospital,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 25.h),
                Text(
                  loc.ourHospitalDescription,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: Theme.of(context).colorScheme.shadow,
                  ),
                ),
                SizedBox(height: 24.h),

                // تعديل هنا: الرؤية والمهمة جنب بعض
                Row(
                  children: [
                    VisionMissionWidget(
                      icon: Icons.remove_red_eye_outlined,
                      title: loc.ourVision,
                      description: loc.visionText,
                    ),
                    VisionMissionWidget(
                      icon: Icons.check_circle_outline,
                      title: loc.ourMission,
                      description: loc.missionText,
                    ),
                  ],
                ),

                SizedBox(height: 24.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border_rounded,
                          size: 24.sp,
                          color: ColorsManager.lightGreen,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          loc.ourValues,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primaryFixed,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      loc.valuesText,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
