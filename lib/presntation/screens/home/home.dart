import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/presntation/screens/home/appBar/home_appBar.dart';
import 'package:aljoud_hospital/presntation/screens/home/categories_item/categories_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/utils/color_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                  children: [
                  const HomeAppBar(),
                    SizedBox(height: 6.h,),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.categories,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsManager.lightGray,
                                minimumSize: const Size(70, 24),
                                padding: REdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                )),
                            child: Text(
                              AppLocalizations.of(context)!.seeAll,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 14.sp, color: ColorsManager.blue2, fontWeight: FontWeight.w700,
                              ),),
                          ),
                        ], 
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoriesItem(imagePath: AssetsManager.cardiology, title: AppLocalizations.of(context)!.cardiology),
                          CategoriesItem(imagePath: AssetsManager.pulmonology, title: AppLocalizations.of(context)!.pulmonology),
                          CategoriesItem(imagePath: AssetsManager.dentistry, title: AppLocalizations.of(context)!.dentistry),
                        ],
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      padding: REdgeInsets.only(right: 15,left: 15 ,top: 45, ),
                      crossAxisSpacing: 15,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildBoxWidget(
                          icon: Icons.video_camera_front_outlined,
                          title: AppLocalizations.of(context)!.onlineConsultation,
                          description: AppLocalizations.of(context)!.bookOnline,
                        ),
                        _buildBoxWidget(
                            icon: Icons.calendar_today,
                            title: AppLocalizations.of(context)!.appointments,
                            description: AppLocalizations.of(context)!.bookAppointment
                        ),
                        _buildBoxWidget(
                          icon: Icons.support_agent,
                          title: AppLocalizations.of(context)!.support,
                          description:
                          AppLocalizations.of(context)!.providingSupport,
                        ),
                        _buildBoxWidget(
                          icon: Icons.assignment,
                          title: AppLocalizations.of(context)!.medicalRecords,
                          description:
                          AppLocalizations.of(context)!.patientInformation,
                        ),
                      ],
                    ),
                  ],
              ),
            ),
        ),
    );
  }

  Widget _buildBoxWidget({required IconData icon,
        required String title,
        required String description})
  {
    return Container(
        padding: REdgeInsets.all(10),
        margin: REdgeInsets.only(bottom: 40,),
        decoration: BoxDecoration(
          color: ColorsManager.lightGray,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                size: 40.sp,
                color: ColorsManager.black2,
              ),
              Text(
                title,
                style: GoogleFonts.sourceSerif4(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.black2,
                  decoration: TextDecoration.underline,
                ),
              ),
              Expanded(
                child: Text(
                  description,
                  style: GoogleFonts.sourceSerif4(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.hint),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
        )
    );
  }
}
