import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/see_all/category_details/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/api_manager/api_manager.dart';
import '../../../../data/model_api/selectedDoctor/Data.dart';
import '../../../../l10n/app_localizations.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor});

  final Data doctor;

  // خرائط الترجمة
  static const Map<String, String> daysTranslations = {
    "Monday": "الإثنين",
    "Tuesday": "الثلاثاء",
    "Wednesday": "الأربعاء",
    "Thursday": "الخميس",
    "Friday": "الجمعة",
    "Saturday": "السبت",
    "Sunday": "الأحد",
  };

  static const Map<String, String> specialtyTranslations = {
    "Pulmonology": "طب الرئة",
    "Cardiology": "طب القلب",
    "Neurology": "طب الأعصاب",
    "Dentistry": "طب الأسنان",
    "Orthopedics": "طب العظام",
    "Pediatrics": "طب الأطفال",
    "Oncology": "طب الأورام",
    "Ophthalmology": "طب العيون",
    "Dermatology": "طب الجلدية",
    "OB-GYN": "نساء وتوليد",
    "Surgery": "جراحة",
    "Physical therapy": "العلاج الطبيعي",
    "Psychiatry": "الطب النفسي",
    "Internal medicine": "الطب الباطني",
    "ENT": "أنف وأذن وحنجرة",
  };

  String translateDay(BuildContext context, String? day) {
    if (day == null) return AppLocalizations.of(context)!.unavailable;
    if (Localizations.localeOf(context).languageCode == 'ar') {
      return daysTranslations[day] ?? day;
    }
    return day;
  }

  String translateSpecialty(BuildContext context, String? specialty) {
    if (specialty == null) return AppLocalizations.of(context)!.unavailable;
    if (Localizations.localeOf(context).languageCode == 'ar') {
      return specialtyTranslations[specialty] ?? specialty;
    }
    return specialty;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final translatedDay = translateDay(context, doctor.day);
    final translatedSpecialty = translateSpecialty(context, doctor.specialty);

    Widget _buildInfoChip(IconData icon, String text) {
      return Container(
        padding: REdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.shadow),
          borderRadius: BorderRadius.circular(20.r),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
                    'https://www.gravatar.com/avatar/?d=mp&f=y&s=200',
                    height: 65.h,
                    width: 65.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.drName ?? loc.unavailable,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          color: ColorsManager.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        translatedSpecialty,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 10.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16.sp),
                          SizedBox(width: 3.w),
                          Text(
                            "${doctor.rating ?? loc.unavailable}",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? "${AppLocalizations.of(context)!.yearsOfExperience} ${doctor.yearExperience ?? 'غير متوفر'}"
                            : "${doctor.yearExperience ?? loc.unavailable} ${AppLocalizations.of(context)!.yearsOfExperience}",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 10.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 5.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildInfoChip(Icons.calendar_today, translatedDay),
                            SizedBox(width: 8.w),
                            _buildInfoChip(Icons.access_time, doctor.date ?? loc.unavailable),
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
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        side: BorderSide(color: Theme.of(context).colorScheme.onPrimaryFixed),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                      ),
                      child: Text(
                        loc.contactHospital,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
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
                        if (doctor.drName != null) {
                          Navigator.pushNamed(context, RoutesManager.hospitalVisit, arguments: doctor);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(loc.noData),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                      ),
                      child: Text(
                        loc.bookHospitalVisit,
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
                        int id = doctor.drID!.toInt();
                        UpdateDoctorForm.show(context, id);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                      ),
                      child: Text(
                        loc.update,
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
                        if (doctor.drID == null) {
                          print("⚠️ Doctor ID is not available");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Doctor ID is not available"),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        print("🔔Deleting doctor with ID: ${doctor.drID}");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: ColorsManager.lightGray,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                              title: Text(
                                loc.deleteConfirmation,
                                style: GoogleFonts.inter(fontSize: 18.sp, color: ColorsManager.black, fontWeight: FontWeight.w600),
                              ),
                              content: Text(
                                loc.deleteQuestion,
                                style: GoogleFonts.inter(fontSize: 14.sp, color: ColorsManager.black),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    loc.no,
                                    style: GoogleFonts.inter(fontSize: 14.sp, color: ColorsManager.black, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    try {
                                      final response = await ApiManger.deleteDoctor(drId: doctor.drID.toString());
                                      print("✅ Delete successfully: ${response.message}");
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            response.message ?? loc.deleteSuccess,
                                            style: const TextStyle(color: Colors.black),
                                          ),
                                          backgroundColor: Colors.green,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      // TODO: Refresh the doctor list here
                                    } catch (e) {
                                      print("❌ Delete failed: $e");
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("${loc.deleteError} $e"),
                                          backgroundColor: Colors.red,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    loc.yes,
                                    style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.red, fontWeight: FontWeight.w500),
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
                        loc.delete,
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
