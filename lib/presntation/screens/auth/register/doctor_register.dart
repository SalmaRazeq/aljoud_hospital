import 'package:aljoud_hospital/core/utils/constant_manager.dart';
import 'package:aljoud_hospital/core/utils/dialog_utils/dialog_utils.dart';
import 'package:aljoud_hospital/data/models/doctor_model.dart';
import 'package:aljoud_hospital/presntation/screens/auth/widget/bottom_section.dart';
import 'package:aljoud_hospital/presntation/screens/auth/widget/toggleButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/email_validation.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../widget/doctor_item/doctor_passwordField.dart';
import '../widget/doctor_item/doctor_textField.dart';


class DoctorRegisterScreen extends StatefulWidget {
  DoctorRegisterScreen({super.key});

  @override
  State<DoctorRegisterScreen> createState() => _DoctorRegisterScreenState();
}

class _DoctorRegisterScreenState extends State<DoctorRegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController medicalLicenseNumController = TextEditingController();
  TextEditingController specializationController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  bool isPatient = false;
  bool value = false;

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
                    SizedBox(height: 30.h,),

                    DoctorTextField(
                      hintText: 'Full Name',
                      controller: fullNameController,
                      icon: Icons.person_outlined,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return AppLocalizations.of(context)!.plzFullName;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 14.h,),

                    DoctorTextField(
                      hintText: 'Phone Number',
                      keyBoardType: const TextInputType.numberWithOptions(),
                      controller: phoneNumController,
                      icon: Icons.phone_outlined,
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

                    SizedBox(height: 14.h,),


                    DoctorTextField(
                        hintText: 'Email Address',
                        controller: emailController,
                        icon: Icons.email_outlined,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return loc.plzEmail;
                          }
                          if (!isEmailValid(input)) {
                            return loc.wrongFormat;
                          }
                          return null;
                        }),

                    SizedBox(height: 14.h,),

                    DoctorPasswordField(
                        hintText: 'Password',
                        controller: passwordController,
                        icon: Icons.lock_outline_rounded,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return loc.plzPassword;
                          }
                          if (input.length < 6) {
                            return loc.password6Char;
                          }
                          return null;
                        }),

                    SizedBox(height: 14.h,),

                    DoctorPasswordField(
                        hintText: 'Confirm Password',
                        controller: rePasswordController,
                        icon: Icons.lock_outline_rounded,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return loc.plzPassword;
                          }
                          if (input.length < 6) {
                            return loc.password6Char;
                          }
                          return null;
                        }),

                    SizedBox(height: 14.h,),

                    DoctorTextField(
                        hintText: 'Medical License Number',
                        controller: medicalLicenseNumController,
                        icon: Icons.school_outlined,
                        keyBoardType: const TextInputType.numberWithOptions(),
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'Please, Enter your medical license number';
                          }
                          return null;
                        }),

                    SizedBox(height: 14.h,),
                    DoctorTextField(
                        hintText: 'Specialization',
                        controller: specializationController,
                        icon: Icons.location_on_outlined,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'Please, Enter your specialization';
                          }
                          return null;
                        }),

                    SizedBox(height: 20.h,),

                    Row(
                      children: [
                        SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: Checkbox(
                              value: value,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  value = newValue!;
                                });
                          }),
                        ),
                       SizedBox(width: 8.w,),
                       Text('I Agree To The Terms & Conditions', style: GoogleFonts.inter(fontSize: 10, color: Theme.of(context).colorScheme.onSecondary),),
                      ],
                    ),

                    SizedBox(height: 14.h,),

                    ElevatedButton(
                      onPressed: () {
                        drSignUp();
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


                    SizedBox(height: 30.h),

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

  void drSignUp() async {
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

      await addDoctorToFireStore(credential.user!.uid);

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

  Future<void> addDoctorToFireStore(String uid) async {
    CollectionReference doctorCollection =
    FirebaseFirestore.instance.collection(DoctorModel.collectionName);

    DocumentReference doctorDocument = doctorCollection.doc(uid);

    DoctorModel doctorDM = DoctorModel(
        doctorId: uid,
        doctorEmail: emailController.text,
        doctorName: fullNameController.text,
        phoneNumber : phoneNumController.text,
      specialty: specializationController.text,
      medicalLicense: medicalLicenseNumController.text
    );
    await doctorDocument.set(doctorDM.toFirestore());
  }

  Future<DoctorModel> getDoctorFromFirestore(String doctorId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection(DoctorModel.collectionName).doc(doctorId).get();

    return DoctorModel.fromFirestore(doc);
  }



}
