import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';
import 'CategoryDetailsScreen.dart';

class DoctorCard extends StatelessWidget {
  DoctorCard({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {

    Widget _buildInfoChip(IconData icon, String text) {
      return Container(
        padding: REdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.shadow),
          borderRadius: BorderRadius.circular(20.r),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          children: [
            Icon(icon, size: 9.sp, color: Theme.of(context).colorScheme.onSecondary),
            SizedBox(width: 2.w),
            Text(
              text,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 8.sp),
              ),
          ],
        ),
      );
    }


    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      margin: REdgeInsets.symmetric(vertical: 10.h),
      elevation: 3,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10.w,vertical: 13.h),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: Image.asset(
                    '${doctor.image}',
                    height: 65.h,
                    width: 65.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13.sp),
                    ),
                    Text(
                      doctor.specialty,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18.sp),
                        SizedBox(width: 5.w),
                        Text("${doctor.rating}", style: Theme.of(context).textTheme.labelSmall,),
                      ],
                    ),
                    Text(Localizations.localeOf(context).languageCode == 'ar'
                        ? "${AppLocalizations.of(context)!.yearsOfExperience} ${doctor.experience}"
                        : "${doctor.experience} ${AppLocalizations.of(context)!.yearsOfExperience}",

                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: 5.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildInfoChip(Icons.calendar_today, '${doctor.month}'),
                        SizedBox(width: 8.w),
                        _buildInfoChip(Icons.access_time, '${doctor.time}'),
                      ],
                    )

                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 24.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(color: Theme.of(context).colorScheme.onPrimaryFixed),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r)),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.contactHospital,
                      style: Theme.of(context).textTheme.labelSmall?.
                      copyWith(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onPrimaryFixed),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesManager.hospitalVisit,
                          arguments: doctor);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text(AppLocalizations.of(context)!.bookHospitalVisit, style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700,color: Theme.of(context).colorScheme.primary)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}