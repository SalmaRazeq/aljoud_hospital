import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/home/categories_item/categories_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../l10n/app_localizations.dart';
import 'appBar/home_appBar.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                  children: [
                   HomeAppBar(),
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
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(RoutesManager.seeAll,);
                            },
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
                              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                color: ColorsManager.blue2, fontWeight: FontWeight.w700,
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
                          InkWell(
                              onTap: (){
                                final category = CategoriesItem(
                                  title: AppLocalizations.of(context)!.cardiology,
                                  imagePath: AssetsManager.cardiology,
                                );

                                Navigator.pushNamed(
                                  context,
                                  RoutesManager.categoryDetails,
                                  arguments: category,
                                );
                              },
                              child: CategoriesItem(imagePath: AssetsManager.cardiology, title: AppLocalizations.of(context)!.cardiology)),
                          InkWell(
                              onTap: (){
                                final category = CategoriesItem(
                                  title: AppLocalizations.of(context)!.pulmonology,
                                  imagePath: AssetsManager.pulmonology,
                                );

                                Navigator.pushNamed(
                                  context,
                                  RoutesManager.categoryDetails,
                                  arguments: category,
                                );
                              },
                              child: CategoriesItem(imagePath: AssetsManager.pulmonology, title: AppLocalizations.of(context)!.pulmonology)),
                          InkWell(
                              onTap: (){
                                final category = CategoriesItem(
                                  title: AppLocalizations.of(context)!.dentistry,
                                  imagePath: AssetsManager.dentistry,
                                );

                                Navigator.of(context).pushNamed(
                                  RoutesManager.categoryDetails,
                                  arguments: category,
                                );
                              },
                              child: CategoriesItem(imagePath: AssetsManager.dentistry, title: AppLocalizations.of(context)!.dentistry)),
                        ],
                      ),
                    ),

                    GridView.count(
                      crossAxisCount: 2,
                      padding: REdgeInsets.only(right: 15,left: 15 ,top: 40),
                      crossAxisSpacing: 14,
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
      ),
    );
  }

  Widget _buildBoxWidget({required IconData icon,
        required String title,
        required String description})
  {
    return Container(
        padding: REdgeInsets.all(10),
        margin: REdgeInsets.only(bottom: 40),
        decoration: BoxDecoration(
          color: ColorsManager.lightGray,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 40.sp,
                color: ColorsManager.darkGray,
              ),
              Text(
                title,
                style: GoogleFonts.sourceSerif4(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.darkGray,
                  decoration: TextDecoration.underline,
                ),
              ),
              Expanded(
                child: Text(
                  description,
                  style: GoogleFonts.sourceSerif4(
                      fontSize: 10.sp,
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
