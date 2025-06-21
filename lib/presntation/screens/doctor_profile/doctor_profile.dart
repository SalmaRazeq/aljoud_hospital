import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/presntation/screens/doctor_profile/widget/about_doctor.dart';
import 'package:aljoud_hospital/presntation/screens/doctor_profile/widget/bottom_bar.dart';
import 'package:aljoud_hospital/presntation/screens/doctor_profile/widget/doctor_appBar.dart';
import 'package:aljoud_hospital/presntation/screens/doctor_profile/widget/doctor_experience_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../data/model_api/selectedDoctor/Data.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/theme_provider.dart';
import '../see_all/category_details/CategoryDetailsScreen.dart';

class DoctorProfileScreen extends StatelessWidget {

   const DoctorProfileScreen({super.key ,});
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments;
    if (data == null || data is! Data) {
      return Scaffold(
        body: Center(
          child: Text(
            AppLocalizations.of(context)!.noData,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.red,
              fontSize: 16.sp,
            ),
          ),
        ),
      );
    }
    final loc = AppLocalizations.of(context)!;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isLightTheme() ? ColorsManager.white : ColorsManager.darkBlue,
      body:  SafeArea(
        child: SingleChildScrollView(
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
                      color:  themeProvider.isLightTheme() ? ColorsManager.lightBlue : ColorsManager.blue3.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20.r)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       ClipRRect(
                         borderRadius: BorderRadius.circular(1.r),
                         child:ClipRRect(
                           borderRadius: BorderRadius.circular(20.r),
                           child: Image.network(
                             'https://www.gravatar.com/avatar/?d=mp&f=y&s=200',
                             height: 100.h,
                             width: 100.w,
                             fit: BoxFit.cover,
                           ),
                         ),

                       ),
                       SizedBox(height: 7.h,),
                       Text('${data.drName}', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16.sp),),
                       Text('${data.specialty}', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 14.sp, color: Theme.of(context).colorScheme.onSecondary)),
                     ],
                  ),
                ),
              ),

              Padding(
                padding: REdgeInsets.symmetric(horizontal: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DoctorExperienceWidget(icon: Icons.person, text: '${1000 ?? '0'}\n${loc.patients}',),
                    DoctorExperienceWidget(icon: Icons.emoji_events, text: '${data.yearExperience ?? '0'} ${loc.yearsOf}\n${loc.experience}',),
                    DoctorExperienceWidget(icon: Icons.star, text: '${data.rating ?? '0'}\n${loc.rating}',),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              AboutDoctor(
                  title: loc.about,
                  body: '${loc.aboutText1} ${data.specialty} ${loc.aboutText2}',
                decoration: Localizations.localeOf(context).languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
              ),
              AboutDoctor(
                  title: loc.workingTime,
                  body: ' date : ${data.date} day :${data.day}',
                  decoration: TextDirection.ltr,
              ),
              AboutDoctor(
                title: loc.price,
                body: data.price,
                decoration: TextDirection.ltr,
              ),

              SizedBox(height: 15.h,),
              const BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
