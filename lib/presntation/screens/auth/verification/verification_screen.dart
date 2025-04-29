import 'package:aljoud_hospital/presntation/screens/auth/forget_password/widgets/elevated_button.dart';
import 'package:aljoud_hospital/presntation/screens/auth/verification/widget/buildOtp_textField.dart';
import 'package:aljoud_hospital/presntation/screens/auth/widget/bottom_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../l10n/app_localizations.dart';

class VerificationScreen extends StatefulWidget {
   final String verificationId;
  VerificationScreen({super.key, required this.verificationId});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String verificationId;

  @override
  void initState() {
    super.initState();
    verificationId = widget.verificationId;
  }

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
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, RoutesManager.forgetPassword);
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          size: 30.sp,
                          color: Theme.of(context).colorScheme.primaryFixed,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Verification",
                            style: GoogleFonts.sourceSans3(
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 50.h),
                    ],
                  ),
                  SizedBox(height: 90.h),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 20.w),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: REdgeInsets.symmetric(horizontal: 40.w),
                              child: Text(
                                "Enter your verification code sent to +0201.........",
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 40.h),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildOtpTextField(
                                  controller: otpController1,
                                  focusNode: focusNode1,
                                  nextFocus: focusNode2,
                                  previousFocus: null,
                                  onCompleted: onCompleted,
                                ),
                                SizedBox(width: 5.w),
                                BuildOtpTextField(
                                  controller: otpController2,
                                  focusNode: focusNode2,
                                  nextFocus: focusNode3,
                                  previousFocus: focusNode1,
                                  onCompleted: onCompleted,
                                ),
                                SizedBox(width: 5.w),
                                BuildOtpTextField(
                                  controller: otpController3,
                                  focusNode: focusNode3,
                                  nextFocus: focusNode4,
                                  previousFocus: focusNode2,
                                  onCompleted: onCompleted,
                                ),
                                SizedBox(width: 5.w),
                                BuildOtpTextField(
                                  controller: otpController4,
                                  focusNode: focusNode4,
                                  nextFocus: focusNode5,
                                  previousFocus: focusNode3,
                                  onCompleted: onCompleted,
                                ),
                                SizedBox(width: 5.w),
                                BuildOtpTextField(
                                  controller: otpController5,
                                  focusNode: focusNode5,
                                  nextFocus: focusNode6,
                                  previousFocus: focusNode4,
                                  onCompleted: onCompleted,
                                ),
                                SizedBox(width: 5.w),
                                BuildOtpTextField(
                                  controller: otpController6,
                                  focusNode: focusNode6,
                                  nextFocus: null,
                                  previousFocus: focusNode5,
                                  onCompleted: onCompleted,
                                ),
                              ],
                            ),

                            SizedBox(height: 30.h),
                            BottomSection(text: "Didn't receive OTP?", body: 'Resend',),
                            SizedBox(height: 75.h),
                            ElevatedButtonDesign(
                              onTap: _allOtpFieldsFilled() ? verifyOtp : () {}, // تأكد من أن الدالة غير اختيارية
                              text: "Verify",
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

  void verifyOtp() async {
    if (_formKey.currentState!.validate() == false) return;

    String otp = otpController1.text +
        otpController2.text +
        otpController3.text +
        otpController4.text +
        otpController5.text +
        otpController6.text;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

    } catch (e) {
      print("Verification failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to verify OTP. Please try again."),
      ));
    }
  }

  void onCompleted() {
    if (_allOtpFieldsFilled()) {
      Navigator.pushReplacementNamed(context, RoutesManager.createNewPassword);
      print("All OTP fields are filled!");
      verifyOtp();
    }
  }

  bool _allOtpFieldsFilled() {
    final controllers = [
      otpController1,
      otpController2,
      otpController3,
      otpController4,
      otpController5,
      otpController6,
    ];
    return controllers.every((controller) => controller.text.isNotEmpty);
  }

}

