import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/email_validation.dart';
import 'package:aljoud_hospital/core/utils/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/routes_manager.dart';
import '../widget/field_design.dart';



class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

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
                Text(StringsManager.welcomeBack,
                  style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 16.h,),
                Text(StringsManager.loginText,
                  style: Theme.of(context).textTheme.displaySmall),
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

                SizedBox(height: 30.h,),
                RegisterDesign(
                    hintText: 'Password',
                    controller: passwordController,
                    isSecure: true,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please, Enter password';
                      }
                      return null;
                    }),
                SizedBox(height: 5.h,),

                Padding(
                    padding: REdgeInsets.only(left: 230),
                    child: TextButton(onPressed: (){}, child: Text(StringsManager.forgetPassword,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 12.sp,color: Theme.of(context).colorScheme.onPrimary)))),

                SizedBox(height: 8.h,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RoutesManager.home);
                  },
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Padding(
                    padding: REdgeInsets.all(13),
                    child: Text(
                      StringsManager.login,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 20.sp, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary)
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

                SizedBox(height: 80.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.notHaveAccount,
                      style: Theme.of(context).textTheme.displaySmall
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesManager.register);
                      },
                      child: Text(
                        StringsManager.signUp,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,decoration: TextDecoration.underline
                        )
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
