import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/see_all/category_details/ubdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/model_api/selectedDoctor/Data.dart';
import '../../../../l10n/app_localizations.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor});

  final Data doctor;

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
          mainAxisSize: MainAxisSize.min, // عشان الـ chip مياخدش مساحة زيادة
          children: [
            Icon(icon, size: 9.sp, color: ColorsManager.darkGray),
            SizedBox(width: 2.w),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: 8.sp),
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
        padding: REdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/3870/3870822.png', // صورة افتراضية ثابتة
                    height: 65.h,
                    width: 65.w,
                    fit: BoxFit.cover,
                  ),
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(50.r),
                //   child: doctor.drPhoto != null && doctor.drPhoto!.isNotEmpty
                //       ? Image.network(
                //     'http://10.0.2.2/c43/${doctor.drPhoto}',
                //     height: 65.h,
                //     width: 65.w,
                //     fit: BoxFit.cover,
                //     errorBuilder: (context, error, stackTrace) => Image.network(
                //       'https://via.placeholder.com/65', // صورة افتراضية من الإنترنت
                //       height: 65.h,
                //       width: 65.w,
                //       fit: BoxFit.cover,
                //     ),
                //   )
                //       : Image.network(
                //     'https://via.placeholder.com/65', // صورة افتراضية لو Dr_Photo null
                //     height: 65.h,
                //     width: 65.w,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                SizedBox(width: 10.w), // قلّصت المسافة عشان الموبايل
                Expanded( // حطيت Expanded عشان الـ Column ميسببش overflow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.drName ?? "غير متوفر",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp, // قلّصت حجم النص للموبايل
                          color: ColorsManager.black,
                        ),
                        overflow: TextOverflow.ellipsis, // عشان النص ميسببش overflow
                        maxLines: 1,
                      ),
                      Text(
                        doctor.specialty ?? "غير متوفر",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 10.sp, // قلّصت حجم النص
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16.sp), // قلّصت حجم الأيقونة
                          SizedBox(width: 3.w),
                          Text(
                            "${doctor.rating ?? 'غير متوفر'}",
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? "${AppLocalizations.of(context)!.yearsOfExperience} ${doctor.yearExperience ?? 'غير متوفر'}"
                            : "${doctor.yearExperience ?? 'غير متوفر'} ${AppLocalizations.of(context)!.yearsOfExperience}",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 10.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 5.h),
                      SingleChildScrollView( // أضفت Scroll عشان الـ chips لو زادت
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildInfoChip(Icons.calendar_today, doctor.day ?? 'غير متوفر'),
                            SizedBox(width: 8.w),
                            _buildInfoChip(Icons.access_time, doctor.date ?? 'غير متوفر'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 24.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded( // حطيت Expanded عشان الأزرار تتوزع صح
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.onPrimaryFixed),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.contactHospital,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp, // قلّصت حجم النص
                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesManager.hospitalVisit,
                            arguments: doctor);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Theme.of(context).colorScheme.onPrimaryFixed,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.bookHospitalVisit,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 24.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        UpdateDoctorForm.show(context, 5);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                      ),
                      child: Text(
                        "Update",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("تأكيد الحذف",
                                  style: TextStyle(color: Colors.black)),
                              content: const Text(
                                  "هل أنت متأكد أنك تريد حذف هذا الدكتور؟",
                                  style: TextStyle(color: Colors.black)),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("لا",
                                      style: TextStyle(color: Colors.black)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // TODO: نفذ الحذف هنا
                                    print("تم الحذف");
                                  },
                                  child: const Text(
                                    "نعم",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: Text(
                        "Delete",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}