import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/email_validation.dart';
import 'package:aljoud_hospital/presntation/screens/auth/widget/bottom_section.dart';
import 'package:aljoud_hospital/presntation/screens/auth/widget/password_field_design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/constant_manager.dart';
import '../../../../core/utils/dialog_utils/dialog_utils.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../data/models/doctor_model.dart';
import '../../../../data/models/user_dm.dart';
import '../../../../l10n/app_localizations.dart';
import '../widget/field_design.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              padding: REdgeInsets.only(top: 50, left: 18, right: 18),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(loc.welcomeBack,
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: 16.h,),
                      Text('${loc.loginText1}\n${AppLocalizations.of(context)!.loginText2}',
                          style: Theme.of(context).textTheme.displaySmall),
                      SizedBox(height: 40.h,),

                      TextFieldDesign(
                          hintText: loc.emailAddress,
                          controller: emailController,
                          validator: (input) {
                            if (input == null || input.trim().isEmpty) {
                              return loc.plzEmail;
                            }

                            return null;
                          }),

                      SizedBox(height: 15.h,),

                      PasswordFieldDesign(
                          hintText: loc.password,
                          controller: passwordController,
                          validator: (input) {
                            if (input == null || input.trim().isEmpty) {
                              return loc.plzPassword;
                            }
                            return null;
                          }),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(RoutesManager.forgetPassword);
                            },
                          child: Text(loc.forgetPassword,
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(fontSize: 10.sp, color: Theme
                                .of(context).colorScheme.onPrimary),
                        ),
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      ElevatedButton(
                        onPressed: () {
                          signIn();
                        },
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: Padding(
                          padding: REdgeInsets.all(6),
                          child: Text(
                              AppLocalizations.of(context)!.login,
                              style: Theme.of(context).textTheme.displaySmall?.
                              copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary)
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
                            // signInWithFacebook();
                          },
                          child: Image.asset(AssetsManager.faceBook)),

                      SizedBox(height: 40.h),
                      BottomSection(text: loc.notHaveAccount, body: loc.signUp, routeName: RoutesManager.register)

                    ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void signIn() async {
    if (formKey.currentState!.validate() == false) return;

    try {
      DialogUtils.showLoading(context, message: AppLocalizations.of(context)!.pleaseWait);

      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );

      await readAccountFromFirestore(credential.user!.uid);

      if (mounted) {
        DialogUtils.hide(context);
        Navigator.pushReplacementNamed(context, RoutesManager.home);
      }

    } on FirebaseAuthException catch (error) {
      DialogUtils.hide(context);
      late String message;
      if (error.code == ConstantManager.invalidCredential) {
        message = AppLocalizations.of(context)!.wrongEorP;
      }
      DialogUtils.showMessage(context, body: message);
    } catch (error) {
      DialogUtils.hide(context);
      DialogUtils.showMessage(context, body: error.toString());
      print(error);
    }
  }

  Future<dynamic> readAccountFromFirestore(String uid) async {
    final firestore = FirebaseFirestore.instance;

    // Check in "Users" collection
    DocumentSnapshot userDoc = await firestore.collection(UserDM.collectionName).doc(uid).get();
    if (userDoc.exists && userDoc.data() != null) {
      return UserDM.fromFireStore(userDoc.data() as Map<String, dynamic>);
    }

    // Check in "Doctors" collection
    DocumentSnapshot doctorDoc = await firestore.collection(DoctorModel.collectionName).doc(uid).get();
    if (doctorDoc.exists && doctorDoc.data() != null) {
      return DoctorModel.fromFirestore(doctorDoc);
    }

    // Not found in any collection
    throw Exception("No user or doctor found with this UID.");

  }
  
}
