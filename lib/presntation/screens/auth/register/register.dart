import 'package:aljoud_hospital/core/utils/constant_manager.dart';
import 'package:aljoud_hospital/core/utils/dialog_utils/dialog_utils.dart';
import 'package:aljoud_hospital/presntation/screens/auth/widget/password_field_design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/email_validation.dart';
import '../../../../core/utils/routes_manager.dart';

import '../../../../data/models/user_dm.dart';
import '../../../../l10n/app_localizations.dart';
import '../widget/field_design.dart';


class RegisterScreen extends StatefulWidget {
   RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController phoneNumController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: REdgeInsets.symmetric(horizontal: 14, vertical: 45),
              padding: REdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppLocalizations.of(context)!.createAccount,
                      style: GoogleFonts.poppins(fontSize: 22.sp, color: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary, fontWeight: FontWeight.w600),),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                        AppLocalizations.of(context)!.fullName,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFieldDesign(
                      hintText: AppLocalizations.of(context)!.enterFullName,
                      controller: fullNameController,
                      validator: (input) {
                        if (input == null || input
                            .trim()
                            .isEmpty) {
                          return AppLocalizations.of(context)!.plzFullName;
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                        AppLocalizations.of(context)!.phone,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFieldDesign(
                      hintText: AppLocalizations.of(context)!.enterPhone,
                      keyBoardType: const TextInputType.numberWithOptions(),
                      controller: phoneNumController,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return AppLocalizations.of(context)!.plzPhone;
                        }
                        if (input.length != 11) {
                          return AppLocalizations.of(context)!.password11digits;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                        AppLocalizations.of(context)!.emailAddress,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFieldDesign(
                        hintText: AppLocalizations.of(context)!.enterEmail,
                        controller: emailController,
                        validator: (input) {
                          if (input == null || input
                              .trim()
                              .isEmpty) {
                            return AppLocalizations.of(context)!.plzEmail;
                          }
                          if (!isEmailValid(input)) {
                            return AppLocalizations.of(context)!.wrongFormat;
                          }
                          return null;
                        }),

                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                        AppLocalizations.of(context)!.password,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                    ),
                    SizedBox(
                      height: 5.h,
                    ),

                    PasswordFieldDesign(
                        hintText: AppLocalizations.of(context)!.enterPassword,
                        controller: passwordController,
                        validator: (input) {
                          if (input == null || input
                              .trim()
                              .isEmpty) {
                            return AppLocalizations.of(context)!.plzPassword;
                          }
                          if (input.length < 6) {
                            return AppLocalizations.of(context)!.password6Char;
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                        AppLocalizations.of(context)!.confirmPassword,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                    ),
                    SizedBox(
                      height: 5.h,
                    ),

                    PasswordFieldDesign(
                        hintText: AppLocalizations.of(context)!.enterPassword,
                        controller: rePasswordController,
                        validator: (input) {
                          if (input == null || input
                              .trim()
                              .isEmpty) {
                            return AppLocalizations.of(context)!.enterPassAgain;
                          }
                          if (input != passwordController.text) {
                            return AppLocalizations.of(context)!.notMatch;
                          }
                          return null;
                        }),

                    SizedBox(
                      height: 35.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signUp();
                      },
                      style: Theme
                          .of(context)
                          .elevatedButtonTheme
                          .style,
                      child: Padding(
                        padding: REdgeInsets.all(10),
                        child: Text(
                            AppLocalizations.of(context)!.signUp,
                            style: Theme
                                .of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary)
                        ),
                      ),
                    ),

                    SizedBox(height: 22.h,),
                    Image.asset(AssetsManager.or,),
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .displaySmall
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RoutesManager.login);
                            },
                          child: Text(
                              AppLocalizations.of(context)!.login,
                              style: Theme.of(context).textTheme.displaySmall?.
                              copyWith(color: Theme.of(context).colorScheme.onPrimary,
                                  decoration: TextDecoration.underline)),
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


  // void signUp() async {
  //   if (formKey.currentState?.validate() ?? false) return;
  //
  //   try {
  //     /// todo: show loading
  //     DialogUtils.showLoading(context, message: 'Please wait...');
  //     UserCredential credential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('username', fullNameController.text);
  //
  //     /// todo: hide loading
  //     if (mounted) {
  //       DialogUtils.hide(context);
  //     } //بتأكد ان ال context موجود علشان اعمله هايد
  //
  //     DialogUtils.showMessage(context, body: 'User register successfully',
  //         posActionTitle: 'Ok',
  //         posAction: () async{
  //           Navigator.pushReplacementNamed(context, RoutesManager.login);          }
  //     );
  //   }
  //
  //   on FirebaseAuthException catch (authError) {
  //     if (mounted) {
  //       DialogUtils.hide(context);
  //     }
  //     late String message;
  //     if (authError.code == ConstantManager.weakPassword) {
  //       message = 'Sorry, Your password is too weak.';
  //
  //       /// todo: show error
  //     }
  //     else if (authError.code == ConstantManager.emailUsed) {
  //       message = 'The account already exists for that email.';
  //
  //       /// todo: show error
  //     }
  //     DialogUtils.showMessage(context, title: 'Error occurred', body: message);
  //   } catch (error) {
  //     if (mounted) {
  //       DialogUtils.hide(context);
  //       DialogUtils.showMessage(
  //           context, title: 'Error occurred', body: error.toString());
  //     }
  //     print(error);
  //   }
  // }

  void signUp() async {
    if (formKey.currentState!.validate() == false) return;

    try {
      DialogUtils.showLoading(context, message: AppLocalizations.of(context)!.pleaseWait);

      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);

      if (credential.user == null) {
        DialogUtils.hide(context);
        DialogUtils.showMessage(context,
            title: AppLocalizations.of(context)!.error, body: AppLocalizations.of(context)!.registrationFailed);
        return;
      }

      await addUserToFireStore(credential.user!.uid);

      if (mounted) DialogUtils.hide(context);

      DialogUtils.showMessage(context,
          title: AppLocalizations.of(context)!.registeredSuccessfully,
          posActionTitle: AppLocalizations.of(context)!.ok,
          posAction: () {
            Navigator.pushReplacementNamed(context, RoutesManager.login);
          });

    } on FirebaseAuthException catch (error) {
      DialogUtils.hide(context);

      String message = AppLocalizations.of(context)!.somethingWentWrong;
      if (error.code == ConstantManager.weakPassword) {
        message = AppLocalizations.of(context)!.passwordTooWeak;
      } else if (error.code == ConstantManager.emailUsed) {
        message = AppLocalizations.of(context)!.accountAlreadyExists;
      }

      DialogUtils.showMessage(context, title: AppLocalizations.of(context)!.error, body: message);
    } catch (error) {
      DialogUtils.hide(context);
      DialogUtils.showMessage(context, title: AppLocalizations.of(context)!.error, body: error.toString());
      print(error);
    }
  }

  Future<void> addUserToFireStore(String uid) async {
    CollectionReference userCollection =
    FirebaseFirestore.instance.collection(UserDM.collectionName);

    DocumentReference userDocument = userCollection.doc(uid);

    UserDM userDM = UserDM(
      id: uid,
      email: emailController.text,
      fullName: fullNameController.text,
      phoneNumber: phoneNumController.text
    );
    await userDocument.set(userDM.toFireStore());
  }

}
