import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/dialog_utils/dialog_utils.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../forget_password/widgets/elevated_button.dart';
import '../widget/password_field_design.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}


class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
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
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, RoutesManager.login);
                          },
                          icon: Icon(Icons.arrow_back_rounded, size: 30.sp, color: Theme.of(context).colorScheme.primaryFixed,)),
                      Expanded(
                        child: Center(
                          child: Text('Create new password', style:
                          GoogleFonts.sourceSans3(fontSize: 24,
                              color: Theme.of(context).colorScheme.primaryFixed),),
                        ),
                      ),
                      SizedBox(width: 40.h,),
                
                    ],
                  ),
                  SizedBox(height: 80.h,),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16,),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Your new password must be different from previous used password.',
                              style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,
                            ),
                
                            SizedBox(height: 60.h,),
                
                            Text(
                                loc.password,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primaryFixed, fontWeight: FontWeight.w600)
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                
                            PasswordFieldDesign(
                                hintText: loc.enterPassword,
                                controller: passwordController,
                                validator: (input) {
                                  if (input == null || input.trim().isEmpty) {
                                    return loc.plzPassword;
                                  }
                                  if (input.length < 6) {
                                    return loc.password6Char;
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                                loc.confirmPassword,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primaryFixed, fontWeight: FontWeight.w600)
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                
                            PasswordFieldDesign(
                                hintText: loc.enterPassword,
                                controller: rePasswordController,
                                validator: (input) {
                                  if (input == null || input.trim().isEmpty) {
                                    return loc.enterPassAgain;
                                  }
                                  if (input != passwordController.text) {
                                    return loc.notMatch;
                                  }
                                  return null;
                                }),
                            SizedBox(height: 60.h,),
                            ElevatedButtonDesign(
                                text: 'Reset password',
                                onTap: (){
                                  changePassword();
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
  void changePassword() async {
    try {
      if (_formKey.currentState!.validate() == false) return;
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(passwordController.text.trim());

        DialogUtils.showMessage(context, title: 'Password updated successfully!');
        DialogUtils.hide(context);

        Navigator.pushReplacementNamed(context, RoutesManager.login);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update password: $e'))
      );
    }
  }
}

