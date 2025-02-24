import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/email_validation.dart';
import '../../../../core/utils/routes_manager.dart';
import '../widget/field_design.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
          child: Container(
            margin: REdgeInsets.symmetric(horizontal: 14,vertical: 45),
            padding: REdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppLocalizations.of(context)!.createAccount, style: GoogleFonts.poppins(fontSize: 22.sp, color: Theme.of(context).colorScheme.onPrimary,fontWeight: FontWeight.w600),),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      AppLocalizations.of(context)!.fullName,
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RegisterDesign(
                    hintText: AppLocalizations.of(context)!.enterFullName,
                    controller: fullNameController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return AppLocalizations.of(context)!.plzFullName;
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                      AppLocalizations.of(context)!.phone,
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RegisterDesign(
                    hintText: AppLocalizations.of(context)!.enterPhone,
                    keyBoardType: const TextInputType.numberWithOptions(),
                    controller: phoneNumController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return AppLocalizations.of(context)!.plzPhone;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                      AppLocalizations.of(context)!.emailAddress,
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RegisterDesign(
                      hintText: AppLocalizations.of(context)!.enterEmail,
                      controller: emailController,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return AppLocalizations.of(context)!.plzEmail;
                        }
                        if (!isEmailValid(input)) {
                          return AppLocalizations.of(context)!.wrongFormat;
                        }
                        return null;
                      }),

                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                      AppLocalizations.of(context)!.password,
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RegisterDesign(
                    hintText: AppLocalizations.of(context)!.enterPassword,
                    controller: passwordController,
                    isSecure: true,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return AppLocalizations.of(context)!.plzPassword;
                      }
                      if (input.length < 6) {return AppLocalizations.of(context)!.password6Char;}
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                      AppLocalizations.of(context)!.confirmPassword,
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RegisterDesign(
                    hintText: AppLocalizations.of(context)!.enterPassword,
                    controller: rePasswordController,
                    isSecure: true,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return AppLocalizations.of(context)!.enterPassAgain;
                      }
                      if (input != passwordController.text) {
                        return AppLocalizations.of(context)!.notMatch;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        formKey.currentState?.save();
                        Navigator.pushReplacementNamed(context, RoutesManager.login);
                      }                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Padding(
                      padding: REdgeInsets.all(13),
                      child: Text(
                          AppLocalizations.of(context)!.signUp,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontSize: 18.sp, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary)
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          AppLocalizations.of(context)!.haveAccount,
                        style: Theme.of(context).textTheme.displaySmall
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RoutesManager.login);
                        },
                        child: Text(
                            AppLocalizations.of(context)!.login,
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
      ),
    );
  }

}

