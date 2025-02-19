import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/email_validation.dart';
import 'package:aljoud_hospital/core/utils/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/routes_manager.dart';
import '../widget/field_design.dart';



class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.only(top: 72, left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(StringsManager.welcomeBack, style: GoogleFonts.sansita(fontSize: 35.sp, fontWeight: FontWeight.w600),),
                SizedBox(height: 16.h,),
                Text(StringsManager.loginText, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ColorsManager.hint),),
                SizedBox(height: 40.h,),
            
                RegisterDesign(hintText: 'Email Address',
                   controller: emailController,
                   validator: (input){
                     if (input == null || input.trim().isEmpty) {
                       return 'Please, Enter email address';
                     }
                     if (!isEmailValid(input)) {
                       return 'Email wrong format';
                     }
                     return null;
                   }),
            
                SizedBox(height: 40.h,),
                RegisterDesign(
                    hintText: 'Password',
                    controller: passwordController,
                    isSecure: true,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Plz, Enter password';
                      }
                      return null;
                    }),
                SizedBox(height: 5.h,),
            
                Padding(
                  padding: REdgeInsets.only(left: 230),
                    child: TextButton(onPressed: (){}, child: Text(StringsManager.forgetPassword, style: GoogleFonts.sourceSans3(fontSize: 13,fontWeight: FontWeight.w600, color: ColorsManager.blue2),))),
            
                SizedBox(height: 8.h,),
                ElevatedButton(
                  onPressed: () {
            
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.blue2,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r))),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Text(
                      StringsManager.login,
                      style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorsManager.white),
                    ),
                  ),
                ),
            
                SizedBox(height: 22.h,),
                Image.asset(AssetsManager.or),
                SizedBox(height: 10.h),
                InkWell(
                    onTap: () {

                    },
                    child: Image.asset(AssetsManager.google)),
                SizedBox(height: 10.h),
                InkWell(

                    onTap: () {

                },
                    child: Image.asset(AssetsManager.faceBook)),
            
                SizedBox(height: 60.h),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.haveAccount,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.hint),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesManager.register);
                      },
                      child: Text(
                        StringsManager.signUp,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorsManager.blue2,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
            
              ]
            ),
          ),
        ),
      ),
    );
  }

}
