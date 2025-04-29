import 'dart:async';
import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/presntation/screens/start/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../l10n/app_localizations.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StartScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(AssetsManager.topLeft)),
              SizedBox(height: 70.h,),
              Center(child: Image.asset(AssetsManager.logo),),
              Text(AppLocalizations.of(context)!.splashText, style: TextStyle(fontSize: 18.sp, color: ColorsManager.lightGreen, fontWeight: FontWeight.bold )),
              SizedBox(height: 136.h,),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(AssetsManager.bottomRight)),
            ],
          ),
        ),
      ),
    );
  }
}
