import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/presntation/screens/doctor_profile/widget/about_doctor.dart';
import 'package:aljoud_hospital/presntation/screens/doctor_profile/widget/bottom_bar.dart';
import 'package:aljoud_hospital/presntation/screens/doctor_profile/widget/doctor_appBar.dart';
import 'package:aljoud_hospital/presntation/screens/doctor_profile/widget/doctor_experience_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../l10n/app_localizations.dart';
import '../see_all/category_details/CategoryDetailsScreen.dart';

class DoctorProfileScreen extends StatelessWidget {
  DoctorProfileScreen({required this.doctor,super.key});
  Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        body:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DoctorAppBar(),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                child: Container(
                  width: double.infinity,
                  height: 210.h,
                  decoration: BoxDecoration(
                      color: ColorsManager.fadedBlue3,
                    borderRadius: BorderRadius.circular(20.r)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       ClipRRect(
                         borderRadius: BorderRadius.circular(1.r),
                         child: Image.asset(
                           doctor.image,
                           height: 100,
                           width: 100,
                           fit: BoxFit.fill,
                         ),),
                       SizedBox(height: 8.h,),
                       Text('${doctor.name}', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16.sp),),
                       Text('${doctor.specialty}', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 14.sp)),
                     ],
                  ),
                ),
              ),
          
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DoctorExperienceWidget(icon: Icons.person, text: '${doctor.hmPatients ?? '0'}\n${loc.patients}',),
                    DoctorExperienceWidget(icon: Icons.emoji_events, text: '${doctor.experience ?? '0'} ${loc.yearsOf}\n${loc.experience}',),
                    DoctorExperienceWidget(icon: Icons.star, text: '${doctor.rating ?? '0'}\n${loc.rating}',),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              AboutDoctor(
                  title: loc.about,
                  body: '${loc.aboutText1} ${doctor.specialty} ${loc.aboutText2}',
                decoration: Localizations.localeOf(context).languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
              ),
              AboutDoctor(
                  title: loc.workingTime,
                  body: '3:30 pm - 10:00 pm  ,  ${loc.workingTimeText}',
                  decoration: TextDirection.ltr,
              ),
              AboutDoctor(
                title: loc.price,
                body: doctor.price,
                decoration: TextDirection.ltr,
              ),
          
              SizedBox(height: 5.h,),
              const BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
