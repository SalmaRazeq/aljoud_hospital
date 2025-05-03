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
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.only(left: 16,right: 16, top:20, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(AssetsManager.startMan, height: 350.h,),
              Text(
                '${AppLocalizations.of(context)!.yourDoctor}\n${AppLocalizations.of(context)!.anyTime}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.primaryFixed, fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(
                AppLocalizations.of(context)!.anyWhere,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: 20.h),
              Text(AppLocalizations.of(context)!.startText,
                style: GoogleFonts.sansita(fontSize: 18.sp,color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),fontWeight: FontWeight.w600 ),),
        
              SizedBox(height: 40.h),
        
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, RoutesManager.login);
                    },
                  style: ElevatedButton.styleFrom(
                      padding: REdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r))
                  ),
                    child: Text(AppLocalizations.of(context)!.getStarted,
                      style: GoogleFonts.sourceSerif4(fontSize: 24.sp, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.primary),),),
              )
        
            ],
          ),
        ),
      ),
    );
  }
}
