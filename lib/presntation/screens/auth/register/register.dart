import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/constant_manager.dart';
import 'package:aljoud_hospital/core/utils/dialog_utils/dialog_utils.dart';
import 'package:aljoud_hospital/presntation/screens/auth/widget/bottom_section.dart';
import 'package:aljoud_hospital/presntation/screens/auth/widget/password_field_design.dart';
import 'package:aljoud_hospital/presntation/screens/auth/widget/toggleButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/email_validation.dart';
import '../../../../core/utils/routes_manager.dart';

import '../../../../data/models/user_dm.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/theme_provider.dart';
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
  bool isPatient = true;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: REdgeInsets.only(left: 14.w, right: 14.w, top: 35.h, bottom: 14.h),
              padding: REdgeInsets.symmetric(horizontal: 10.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){Navigator.pushNamed(context, RoutesManager.login);},
                            icon: Icon(Icons.arrow_back_rounded,
                              color: Theme.of(context).colorScheme.onSecondary,
                              size: 20.sp,)),
                        SizedBox(width: 15.w,),
                        Center(
                          child: Text(loc.createAccount,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: 20.sp, color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w600
                            ),),),
                      ],
                    ),
                    SizedBox(height: 8.h,),

                    ToggleButtonWidget(
                      isPatientSelected: isPatient,
                      onToggle: (value) {
                        setState(() {
                          isPatient = value;
                        });
                        if (isPatient) {
                          Navigator.pushNamed(context, RoutesManager.register);
                        }
                        else {
                          Navigator.pushNamed(context, RoutesManager.doctorRegister);
                        }
                      },
                    ),

                    SizedBox(height: 20.h,),
                    Text(
                        loc.fullName,
                        style: Theme.of(context).textTheme.titleMedium
                    ),

                    SizedBox(height: 5.h,),

                    TextFieldDesign(
                      hintText: loc.enterFullName,
                      controller: fullNameController,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return AppLocalizations.of(context)!.plzFullName;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 8.h,),
                    Text(
                        loc.phone,
                        style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(height: 5.h,),

                    TextFieldDesign(
                      hintText: loc.enterPhone,
                      keyBoardType: const TextInputType.numberWithOptions(),
                      controller: phoneNumController,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return loc.plzPhone;
                        }
                        if (input.length != 11) {
                          return loc.password11digits;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h,),

                    Text(
                        loc.emailAddress,
                        style: Theme.of(context).textTheme.titleMedium
                    ),
                    SizedBox(height: 5.h,),
                    TextFieldDesign(
                        hintText: loc.enterEmail,
                        controller: emailController,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return loc.plzEmail;
                          }
                          if (!isEmailValid(input)) {
                            return loc.wrongFormat;
                          }
                          return null;
                        }),

                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                        loc.password,
                        style: Theme.of(context).textTheme.titleMedium
                    ),
                    SizedBox(
                      height: 5.h,
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
                      height: 9.h,
                    ),
                    Text(
                        loc.confirmPassword,
                        style: Theme.of(context).textTheme.titleMedium
                    ),
                    SizedBox(
                      height: 5.h,
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

                    SizedBox(height: 35.h,),

                    ElevatedButton(
                      onPressed: () {
                        signUp();
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Padding(
                        padding: REdgeInsets.all(6),
                        child: Text(
                            loc.signUp,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary)
                        ),
                      ),
                    ),

                    SizedBox(height: 22.h,),
                    Image.asset(themeProvider.isLightTheme() ? AssetsManager.or : AssetsManager.darkOr,),
                    SizedBox(height: 10.h),
                    InkWell(
                        onTap: () {},
                        child: Image.asset(AssetsManager.google)),
                    SizedBox(height: 10.h),

                    InkWell(
                        onTap: () {},
                        child: Image.asset(AssetsManager.faceBook)),
                    SizedBox(height: 40.h),

                    BottomSection(text: loc.haveAccount, body: loc.login, routeName: RoutesManager.login,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void signUp() async {
    final loc = AppLocalizations.of(context)!;

    if (formKey.currentState!.validate() == false) return;

    try {
      DialogUtils.showLoading(context, message: loc.pleaseWait);

      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);

      if (credential.user == null) {
        DialogUtils.hide(context);
        DialogUtils.showMessage(context,
            title: loc.error, body: loc.registrationFailed);
        return;
      }

      await addUserToFireStore(credential.user!.uid);

      if (mounted) DialogUtils.hide(context);

      DialogUtils.showMessage(context,
          title: loc.registeredSuccessfully,
          posActionTitle: loc.ok,
          posAction: () {
            Navigator.pushReplacementNamed(context, RoutesManager.login);
          });

    } on FirebaseAuthException catch (error) {
      DialogUtils.hide(context);

      String message = loc.somethingWentWrong;
      if (error.code == ConstantManager.weakPassword) {
        message = loc.passwordTooWeak;
      } else if (error.code == ConstantManager.emailUsed) {
        message = loc.accountAlreadyExists;
      }

      DialogUtils.showMessage(context, title: loc.error, body: message);
    } catch (error) {
      DialogUtils.hide(context);
      DialogUtils.showMessage(context, title: loc.error, body: error.toString());
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
