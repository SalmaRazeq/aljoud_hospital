import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/email_validation.dart';
import 'package:aljoud_hospital/presntation/screens/auth/widget/password_field_design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/constant_manager.dart';
import '../../../../core/utils/dialog_utils/dialog_utils.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../data/models/user_dm.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/theme_provider.dart';
import '../widget/field_design.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(AppLocalizations.of(context)!.welcomeBack,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge),
                      SizedBox(height: 16.h,),
                      Text('${AppLocalizations.of(context)!
                          .loginText1}\n${AppLocalizations.of(context)!
                          .loginText2}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .displaySmall),
                      SizedBox(height: 40.h,),

                      TextFieldDesign(
                          hintText: AppLocalizations.of(context)!.emailAddress,
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

                      SizedBox(height: 15.h,),

                      PasswordFieldDesign(
                        hintText: AppLocalizations.of(context)!.password,
                        controller: passwordController,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return AppLocalizations.of(context)!.plzPassword;
                            }
                            if (input.length < 6) {
                            return AppLocalizations.of(context)!.password6Char;
                          }
                            return null;
                        },
                        onSubmit: signIn,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RoutesManager.forgetPassword);
                            }, child: Text(AppLocalizations.of(
                            context)!.forgetPassword,
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(fontSize: 10.sp, color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        ),
                      ),

                      SizedBox(height: 8.h,),
                      ElevatedButton(
                        onPressed: () {
                          signIn();
                        },
                        style: Theme
                            .of(context)
                            .elevatedButtonTheme
                            .style,
                        child: Padding(
                          padding: REdgeInsets.all(10),
                          child: Text(
                              AppLocalizations.of(context)!.login,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.primary)
                          ),
                        ),
                      ),

                      SizedBox(height: 22.h,),
                      Image.asset(themeProvider.isLightTheme() ? AssetsManager.or : AssetsManager.darkOr,),
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

                      SizedBox(height: 60.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              AppLocalizations.of(context)!.notHaveAccount,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displaySmall
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, RoutesManager.register);
                            },
                            child: Text(
                                AppLocalizations.of(context)!.signUp,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onPrimary,
                                    decoration: TextDecoration.underline
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

  void signIn() async {
    if (formKey.currentState!.validate() == false) return;

    try {
      DialogUtils.showLoading(context, message: AppLocalizations.of(context)!.pleaseWait);

      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      UserDM.currentUser = await readUserFromFireStore(credential.user!.uid);

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

  Future<UserDM> readUserFromFireStore(String uid) async{
    CollectionReference userCollection =
    FirebaseFirestore.instance.collection(UserDM.collectionName);

    DocumentReference userDocument = userCollection.doc(uid);

    DocumentSnapshot userDocSnapShot = await userDocument.get();
    Map<String, dynamic> json =userDocSnapShot.data() as Map<String, dynamic>;
    UserDM userDM = UserDM.fromFireStore(json);
    return userDM;
  }


}
