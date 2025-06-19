import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/see_all/category_details/ubdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/api_manager/api_manager.dart';
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
                    'https://cdn-icons-png.flaticon.com/512/3870/3870822.png',
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
                        doctor.drName ?? "غير متوفر",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 12.sp,
                              color: ColorsManager.black,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        doctor.specialty ?? "غير متوفر",
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
                            "${doctor.rating ?? 'غير متوفر'}",
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
                            : "${doctor.yearExperience ?? 'غير متوفر'} ${AppLocalizations.of(context)!.yearsOfExperience}",
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
                            _buildInfoChip(Icons.calendar_today,
                                doctor.day ?? 'غير متوفر'),
                            SizedBox(width: 8.w),
                            _buildInfoChip(
                                Icons.access_time, doctor.date ?? 'غير متوفر'),
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
                        side: BorderSide(
                            color:
                                Theme.of(context).colorScheme.onPrimaryFixed),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.contactHospital,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 10.sp,
                              color:
                                  Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if ( doctor.drName!=null ) {
                          Navigator.pushNamed(
                              context, RoutesManager.hospitalVisit,
                              arguments: doctor);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  " No data"),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
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
                        int id = doctor.drID!.toInt();
                        UpdateDoctorForm.show(context, id);
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
                        if (doctor.drID == null) {
                          print("⚠️ drID is null");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("معرف الدكتور غير متوفر"),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        print("🔔 Initiating delete for Dr_ID: ${doctor.drID}");
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
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    try {
                                      final response =
                                          await ApiManger.deleteDoctor(
                                        drId: doctor.drID.toString(),
                                      );
                                      print(
                                          "✅ Delete successful: ${response.message}");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            response.message ??
                                                "تم حذف الدكتور بنجاح",
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          backgroundColor: Colors.green,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      // TODO: Refresh the doctor list here
                                      // Example: Provider.of<DoctorProvider>(context, listen: false).refreshDoctors();
                                    } catch (e) {
                                      print("❌ Delete failed: $e");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("حدث خطأ: $e"),
                                          backgroundColor: Colors.red,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    }
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
