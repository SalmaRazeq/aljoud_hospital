import 'package:aljoud_hospital/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/email_validation.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../widget/field_design.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});

  TextEditingController fullNameController = TextEditingController();

  TextEditingController phoneNumController = TextEditingController();

   TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
        child: Container(
          margin: REdgeInsets.symmetric(horizontal: 14,vertical: 18),
          padding: REdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(StringsManager.createAccount, style: GoogleFonts.poppins(fontSize: 28, color: Theme.of(context).colorScheme.onPrimary,fontWeight: FontWeight.w600),),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Full name',
                  style: Theme.of(context).textTheme.titleMedium
                ),
                SizedBox(
                  height: 5.h,
                ),
                RegisterDesign(
                  hintText: 'Enter your full name',
                  controller: fullNameController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Please, Enter full name';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'Phone number',
                  style: Theme.of(context).textTheme.titleMedium
                ),
                SizedBox(
                  height: 5.h,
                ),
                RegisterDesign(
                  hintText: 'Enter your phone number',
                  keyBoardType: const TextInputType.numberWithOptions(),
                  controller: phoneNumController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Please, Enter phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'E-mail address',
                  style: Theme.of(context).textTheme.titleMedium
                ),
                SizedBox(
                  height: 5.h,
                ),
                RegisterDesign(
                    hintText: 'Enter your email address',
                    controller: emailController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please, Enter email address';
                      }
                      if (!isEmailValid(input)) {
                        return 'Email wrong format';
                      }
                      return null;
                    }),

                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.titleMedium
                ),
                SizedBox(
                  height: 5.h,
                ),
                RegisterDesign(
                  hintText: 'Enter your password',
                  controller: passwordController,
                  isSecure: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Please, Enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'Confirm password',
                  style: Theme.of(context).textTheme.titleMedium
                ),
                SizedBox(
                  height: 5.h,
                ),
                RegisterDesign(
                  hintText: 'Enter your password',
                  controller: rePasswordController,
                  isSecure: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Enter the password again';
                    }
                    if (input != passwordController.text) {
                      return "Password doesn't match";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35.h,
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Padding(
                    padding: REdgeInsets.all(13),
                    child: Text(
                      StringsManager.signUp,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.haveAccount,
                      style: Theme.of(context).textTheme.displaySmall
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesManager.login);
                      },
                      child: Text(
                        StringsManager.login,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary, decoration: TextDecoration.underline
                        )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
