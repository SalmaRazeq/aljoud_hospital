import 'dart:math';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/data/models/user_dm.dart';
import 'package:aljoud_hospital/presntation/screens/auth/forget_password/widgets/elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/dialog_utils/dialog_utils.dart';
import '../../../../core/utils/email_validation.dart';
import '../../../../l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_rounded, size: 24.sp, color: Theme.of(context).colorScheme.primaryFixed),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            loc.changePassword,
                            style: GoogleFonts.sourceSans3(
                              fontSize: 22.sp,
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
                    padding: REdgeInsets.symmetric(horizontal: 50),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              loc.enterEmailToReset,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: 14.sp),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40.h),
                            Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: const BoxDecoration(
                                color: ColorsManager.blue4,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.email_outlined,
                                color: ColorsManager.white,
                                size: 56.sp,
                              ),
                            ),
                            SizedBox(height: 50.h),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontSize: 14.sp, color: ColorsManager.black),
                                validator: (input) {
                                  if (input == null || input.trim().isEmpty) {
                                    return loc.plzEmail;
                                  }
                                  if (!isEmailValid(input)) {
                                    return loc.wrongFormat;
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (_) =>
                                    _resetPasswordWithEmail(context),
                                // ← هنا الإضافة
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: loc.emailAddress,
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
                            SizedBox(height: 14.h),
                            ElevatedButtonDesign(
                              text: loc.sendResetLink,
                              onTap: () {
                                _resetPasswordWithEmail(context);
                              },
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


  Future<void> _resetPasswordWithEmail(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final email = emailController.text.trim().toLowerCase();
    try {
      DialogUtils.showLoading(context, message: 'Please wait...');

      // تحقق أولاً من أن الإيميل مسجل في Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection(UserDM.collectionName)
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        DialogUtils.hide(context);
        DialogUtils.showMessage(
          context,
          title: 'Error',
          body: 'This email is not registered.',
        );
        return;
      }

      // إذا الإيميل موجود بالفعل، أرسل رابط إعادة التعيين
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      DialogUtils.hide(context);
      DialogUtils.showMessage(
        context,
        title: 'Success',
        body: 'A password reset link has been sent to your email.',
      );
    } catch (e) {
      DialogUtils.hide(context);
      DialogUtils.showMessage(
        context,
        title: 'Error',
        body: 'An unexpected error occurred: $e',
      );
    }
  }



  String generateOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString(); // كود من 6 أرقام
  }

}
