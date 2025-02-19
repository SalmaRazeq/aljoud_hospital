import 'dart:async';

import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/strings_manager.dart';
import 'package:aljoud_hospital/presntation/screens/home/home.dart';
import 'package:aljoud_hospital/presntation/screens/start/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/routes_manager.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Start()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(AssetsManager.topLeft)),
            SizedBox(height: 70.h,),
            Center(child: Image.asset(AssetsManager.logo),),
            Text(StringsManager.splashText, style: TextStyle(fontSize: 18.sp, color: ColorsManager.lightGreen, fontWeight: FontWeight.bold )),
            SizedBox(height: 130.h,),
            Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(AssetsManager.bottomRight)),
          ],
        ),
      ),
    );
  }
}
