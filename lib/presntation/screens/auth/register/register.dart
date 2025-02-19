import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/email_validation.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../widget/field_design.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   late TextEditingController fullNameController;
   //use ?

  late TextEditingController phoneNumController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController rePasswordController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    fullNameController = TextEditingController();
    phoneNumController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    phoneNumController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: Text('SinUP',style:TextStyle(color: ColorsManager.black,fontWeight:FontWeight.w700,fontSize: 20 ) ,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 55.h,
                ),
                Text(
                  'Full name',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: 10.h,
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
                  height: 15.h,
                ),
                Text(
                  'Phone number',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                RegisterDesign(
                  hintText: 'Enter your phone number',
                  controller: phoneNumController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Please, Enter phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'E-mail address',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: 10.h,
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
                  height: 8.h,
                ),
                Text(
                  'Password',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: 10.h,
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
                  height: 15.h,
                ),
                Text(
                  'Confirm password',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: 10.h,
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.blue2,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r))),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Text(
                      StringsManager.signUp,
                      style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorsManager.white),
                    ),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account!",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesManager.login);
                      },
                      child: Text(
                        'Sign_in',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: ColorsManager.blue2,
                            decoration: TextDecoration.underline),
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
