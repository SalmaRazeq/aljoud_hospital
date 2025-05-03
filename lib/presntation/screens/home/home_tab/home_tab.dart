import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/home/categories_item/categories_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/theme_provider.dart';
import 'appBar/home_appBar.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    Widget _buildBoxWidget({required IconData icon,
      required String title,
      required String description,
      required VoidCallback onTap
    })
    {

      return InkWell(
        onTap: onTap,
        child: Container(
            padding: REdgeInsets.all(10),
            margin: REdgeInsets.only(bottom: 40.h),
            decoration: BoxDecoration(
              color: themeProvider.isLightTheme() ? ColorsManager.lightGray : ColorsManager.white,
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
        ),
      );
    }

    return  GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
                children: [
                 HomeAppBar(),
                  SizedBox(height: 6.h,),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Row(
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
                                  minimumSize: Size(70.w, 24.h),
                                  padding: REdgeInsets.symmetric(vertical: 4.h, horizontal: 20.w,
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
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
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


                      ],
                    ),
                  ),

                  GridView.count(
                    crossAxisCount: 2,
                    padding: REdgeInsets.only(right: 15.w,left: 15.w ,top: 50.h),
                    crossAxisSpacing: 14,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildBoxWidget(
                        icon: Icons.video_camera_front_outlined,
                        title: AppLocalizations.of(context)!.onlineConsultation,
                        description: AppLocalizations.of(context)!.bookOnline,
                        onTap: (){}
                      ),
                      _buildBoxWidget(
                          icon: Icons.local_hospital,
                          title: AppLocalizations.of(context)!.aboutHospital,
                          description: AppLocalizations.of(context)!.aboutHospitalText,
                          onTap: (){}
                      ),
                      _buildBoxWidget(
                        icon: Icons.support_agent,
                        title: AppLocalizations.of(context)!.support,
                        description: AppLocalizations.of(context)!.providingSupport,
                        onTap: (){}
                      ),
                      _buildBoxWidget(
                        icon: Icons.assignment,
                        title: AppLocalizations.of(context)!.medicalRecords,
                        description: AppLocalizations.of(context)!.patientInformation,
                        onTap: (){}
                      ),
                    ],
                  ),
                ],
            ),
          ),
      ),
    );
  }


}
