import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/email_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../widget/field_design.dart';



class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: (){
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.only(top: 72, left: 18, right: 18),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppLocalizations.of(context)!.welcomeBack,
                      style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 16.h,),
                    Text('${AppLocalizations.of(context)!.loginText1}\n${AppLocalizations.of(context)!.loginText2}',
                      style: Theme.of(context).textTheme.displaySmall),
                    SizedBox(height: 40.h,),

                    RegisterDesign(hintText: AppLocalizations.of(context)!.emailAddress,
                        controller: emailController,
                        validator: (input){
                          if (input == null || input.trim().isEmpty) {
                            return AppLocalizations.of(context)!.plzEmail;
                          }
                          if (!isEmailValid(input)) {
                            return AppLocalizations.of(context)!.wrongFormat;
                          }
                          return null;
                        }),

                    SizedBox(height: 15.h,),


                    RegisterDesign(
                        hintText: AppLocalizations.of(context)!.password,
                        controller: passwordController,
                        isSecure: true,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return AppLocalizations.of(context)!.plzPassword;
                          }
                          if (input.length < 6) {return AppLocalizations.of(context)!.password6Char;}
                          return null;
                        }),

                    SizedBox(height: 5.h,),

                    Padding(
                        padding: REdgeInsets.only(left: 230),
                        child: TextButton(onPressed: (){}, child: Text(AppLocalizations.of(context)!.forgetPassword,
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 12.sp,color: Theme.of(context).colorScheme.onPrimary)))),

                    SizedBox(height: 8.h,),
                    ElevatedButton(
                      onPressed: () {
                       if (formKey.currentState?.validate() ?? false) {
                         formKey.currentState?.save();
                         Navigator.pushReplacementNamed(context, RoutesManager.home);
                       }
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Padding(
                        padding: REdgeInsets.all(13),
                        child: Text(
                            AppLocalizations.of(context)!.login,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            AppLocalizations.of(context)!.notHaveAccount,
                          style: Theme.of(context).textTheme.displaySmall
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RoutesManager.register);
                          },
                          child: Text(
                              AppLocalizations.of(context)!.signUp,
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
      ),
    ),
  );
}
}
