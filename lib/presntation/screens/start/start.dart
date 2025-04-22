import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../l10n/app_localizations.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 60.h),
            Image.asset(AssetsManager.startMan),
            Text(
              '${AppLocalizations.of(context)!.yourDoctor}\n${AppLocalizations.of(context)!.anyTime}\n${AppLocalizations.of(context)!.anyWhere}',
              style: GoogleFonts.sansita(fontSize: 34.sp, fontWeight: FontWeight.bold, color: ColorsManager.blue),),

            SizedBox(height: 6.h),
            Text(AppLocalizations.of(context)!.startText,
              style: GoogleFonts.sansita(fontSize: 20,color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w600 ),),

            SizedBox(height: 60.h),

            Container(
              margin: REdgeInsets.symmetric(horizontal: 50),
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, RoutesManager.login);
                  },
                style: ElevatedButton.styleFrom(
                  padding: REdgeInsets.all(10),
                  backgroundColor: ColorsManager.blue,
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))
                ),
                  child: Text(AppLocalizations.of(context)!.getStarted,
                    style: GoogleFonts.sourceSerif4(fontSize: 28, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.primary),),),
            )

          ],
        ),
      ),
    );
  }
}
