import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/auth/forget_password/widgets/elevated_button.dart';
import 'package:aljoud_hospital/presntation/screens/auth/verification/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/dialog_utils/dialog_utils.dart';
import '../../../../l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
   ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController phoneNumController = TextEditingController(text: '+20');

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, RoutesManager.login);
                          },
                          icon: Icon(Icons.arrow_back_rounded, size: 30.sp, color: Theme.of(context).colorScheme.primaryFixed,)),
                      Expanded(
                        child: Center(
                          child: Text('Forget password', style:
                          GoogleFonts.sourceSans3(fontSize: 24,
                              color: Theme.of(context).colorScheme.primaryFixed),),
                        ),
                      ),
                      SizedBox(width: 50.h,),

                    ],
                  ),
                  SizedBox(height: 90.h,),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 50,),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Enter your phone number to reset your password.',
                                style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40.h,),

                            Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: const BoxDecoration(
                                color: ColorsManager.blue4,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.phone,
                                color: ColorsManager.white,
                                size: 56.sp,
                              ),
                            ),
                            SizedBox(height: 50.h,),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.1), // لون الظل مع شفافية
                                    blurRadius: 4, // مدى انتشار الظل
                                    offset: const Offset(0, 0), // اتجاه الظل (يمين/يسار + فوق/تحت)
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                width: 260.w,
                                child: TextFormField(
                                  autofocus: true,
                                  controller: phoneNumController,
                                  keyboardType: const TextInputType.numberWithOptions(),
                                  style: TextStyle(fontSize: 14.sp),
                                  validator: (input) {
                                    if (input == null || input.trim().isEmpty) {
                                      return loc.plzPhone;
                                    }
                                    if (input.length != 13) {  // الرقم يجب أن يتكون من 13 رقمًا (رمز البلد + 10 أرقام)
                                      return loc.password11digits;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Phone number',
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: 13.sp,
                                      color: ColorsManager.hint,
                                    ),
                                    errorStyle: GoogleFonts.roboto(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    filled: true,
                                    fillColor: ColorsManager.white,
                                    contentPadding: REdgeInsets.symmetric(vertical: 9.h, horizontal: 12.w),
                                    constraints: BoxConstraints(minHeight: 50.h),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(color: ColorsManager.hint),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(color: ColorsManager.hint),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(color: Colors.red, width: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h,),
                            ElevatedButtonDesign(
                                text: 'Reset password',
                                onTap: (){
                                  sendOtpForPasswordReset(context);

                                }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

   void sendOtpForPasswordReset(BuildContext context) async {
    if (_formKey.currentState!.validate() == false) return;

    try {
      DialogUtils.showLoading(context, message: AppLocalizations.of(context)!.pleaseWait);

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) {
        },

        codeSent: (String verificationId, int? resendToken) {
          DialogUtils.hide(context);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(verificationId: verificationId,),
            ),
          );
          },

        verificationFailed: (FirebaseAuthException e) {
          print('Verification Failed: ${e.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
          DialogUtils.hide(context);
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          DialogUtils.showMessage(context,title: 'Code retrieval timed out, please try again');
          DialogUtils.hide(context);
        },
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      DialogUtils.hide(context);
    }
  }
}