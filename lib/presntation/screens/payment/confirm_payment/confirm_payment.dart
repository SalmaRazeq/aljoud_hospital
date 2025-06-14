import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/routes_manager.dart';
import '../../../../data/models/doctor/doctor_model.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/theme_provider.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  ConfirmPaymentScreen({super.key, required this.doctor});
  final DoctorModel doctor;


  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.only(top: 70.h, right: 25.w, left: 25.w, bottom: 20.h ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: const BoxDecoration(
                    color: ColorsManager.fadedGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: ColorsManager.lightGreen,
                    size: 56.sp,
                  ),
                ),
                SizedBox(height: 14.h,),
                Text('${loc.appointment}\n${loc.confirmed}', style: GoogleFonts.sourceSans3(fontSize: 22.sp, color: Theme.of(context).colorScheme.primaryFixed),textAlign: TextAlign.center,),
                SizedBox(height: 20.h,),
                Text('${doctor.doctorName}' , style: GoogleFonts.sourceSans3(fontSize: 20.sp, color: Theme.of(context).colorScheme.onSecondary),),
                SizedBox(height: 5.h,),
                Text('${doctor.date} . ${doctor.time}' , style: GoogleFonts.sourceSans3(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSecondary),),
                Text(loc.hospitalName , style: GoogleFonts.sourceSans3(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSecondary),),
                Text('${loc.paid}  ${(doctor.price)}' , style: GoogleFonts.sourceSans3(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSecondary),),
                SizedBox(height: 40.h,),
                Center(
                  child: Text(loc.bookingText ,
                    style: GoogleFonts.inter(fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSecondary),
                    textAlign: TextAlign.center,
                  ),
                ),
            
                SizedBox(height: 40.h,),
                Center(
                  child: SizedBox(
                      width: 260.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutesManager.home, // الشاشة اللي فيها الـ BottomNavigationBar
                                (route) => false,
                            arguments: 2, // رقم التبويبة، 1 يعني MyBookings مثلا
                          );
                          },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.lightGray,
                          elevation: 0,
                          padding: REdgeInsets.all(6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                              side: const BorderSide(color: ColorsManager.hint)
                          ),
                        ),
                        child: Text(
                          loc.viewMyBooking,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: themeProvider.isLightTheme() ? ColorsManager.blue2 : ColorsManager.darkBlue1),
                        ),
                      )),
                ),
                SizedBox(height: 10.h,),
                Center(
                  child: SizedBox(
                      width: 260.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, RoutesManager.home, (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.lightGray,
                          elevation: 0,
                          padding: REdgeInsets.all(6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            side: const BorderSide(color: ColorsManager.hint)
                          ),
                        ),
                        child: Text(
                          loc.backHome,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorsManager.black),
                        ),
                      )),
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
