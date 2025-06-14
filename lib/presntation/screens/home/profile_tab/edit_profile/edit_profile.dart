import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/dialog_utils/dialog_utils.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/auth/forget_password/widgets/elevated_button.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/edit_profile/widget/editProfile_textField.dart';
import 'package:aljoud_hospital/presntation/screens/widgets/build_circleButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/email_validation.dart';
import '../../../../../data/models/user_dm.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../../providers/theme_provider.dart';

class EditeProfileScreen extends StatefulWidget {
  EditeProfileScreen({super.key});

  @override
  State<EditeProfileScreen> createState() => _EditeProfileScreenState();
}

class _EditeProfileScreenState extends State<EditeProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? userName,
      userPhone,
      userEmail,
      userHeight,
      userWeight,
      day,
      month,
      year;
  String? calculatedAge;
  bool isLoading = true;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserName();
    });
  }

  Future<void> loadUserName() async {
    DialogUtils.showLoading(context,
        message: AppLocalizations.of(context)!.loading);

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firestore = FirebaseFirestore.instance;
      DocumentSnapshot userDoc = await firestore.collection(UserDM.collectionName).doc(user.uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        UserDM userDM = UserDM.fromFireStore(userDoc.data() as Map<String, dynamic>);

        if (userDM.fullName != null) nameController.text = userDM.fullName!;
        if (userDM.email != null) emailController.text = userDM.email!;
        if (userDM.phoneNumber != null) phoneNumController.text = userDM.phoneNumber!;
        if (userDM.height != null) heightController.text = userDM.height!.toString();
        if (userDM.weight != null) weightController.text = userDM.weight!.toString();
        day = userDM.day ?? null;
        month = userDM.month ?? null;
        year = userDM.year ?? null;

        if (userDM.age != null) {
          calculatedAge = userDM.age;
        }

        setState(() {
          userName = userDM.fullName;
          userPhone = userDM.phoneNumber;
          userEmail = userDM.email;
          userHeight = userDM.height?.toString();
          userWeight = userDM.weight?.toString();
          day = userDM.day?.toString();
          month = userDM.month?.toString();
          year = userDM.year?.toString();
          isLoading = false;
        });
        Navigator.pop(context);
      }
    }
  }

  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    var themeProvider = Provider.of<ThemeProvider>(context);

    Widget _TextLabelSmall(String label) {
      return Padding(
        padding: REdgeInsets.only(top: 18.h, bottom: 6.h),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 11.sp),
        ),
      );
    }

    Widget _TextLabel(String label) {
      return Padding(
        padding: REdgeInsets.only(top: 18.h, bottom: 6.h),
        child: Text(
          label,
          style:
              Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: REdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        BuildCircleButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutesManager.home,
                              (route) => false,
                              arguments: 3,
                            );
                          },
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              loc.editProfile,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 24.sp),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TextLabel(loc.name),
                        EditprofileTextfield(
                          hintText: userName ?? '--',
                          controller: nameController,
                          validator: (value) => null,
                        ),
                        _TextLabel(loc.phone),
                        EditprofileTextfield(
                          hintText: userPhone ?? '--',
                          controller: phoneNumController,
                          validator: (input) {
                            if (input == null || input.length != 11) {
                              return loc.password11digits;
                            }
                            return null;
                          },
                          keyBoardType: const TextInputType.numberWithOptions(),
                        ),
                        _TextLabel(loc.emailAddress),
                        EditprofileTextfield(
                          hintText: userEmail ?? '--',
                          controller: emailController,
                          validator: (input) {
                            if (input == null || !isEmailValid(input)) {
                              return loc.wrongFormat;
                            }
                            return null;
                          },
                        ),
                        _TextLabel(loc.birthdate),
                        Row(
                          children: [
                            Expanded(
                              child: EditprofileTextfield(
                                hintText: day ?? '--',
                                controller: dayController,
                                keyBoardType:
                                    const TextInputType.numberWithOptions(),
                                validator: (input) => null,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: EditprofileTextfield(
                                hintText: month ?? '--',
                                controller: monthController,
                                keyBoardType:
                                    const TextInputType.numberWithOptions(),
                                validator: (input) => null,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: EditprofileTextfield(
                                hintText: year ?? '--',
                                controller: yearController,
                                keyBoardType:
                                    const TextInputType.numberWithOptions(),
                                validator: (input) {
                                  if (input == null || input.length != 4) {
                                    return 'Enter the year right';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      _TextLabel(loc.height),
                                      SizedBox(width: 4.w),
                                      _TextLabelSmall(loc.cm)
                                    ],
                                  ),
                                  EditprofileTextfield(
                                    hintText: userHeight ?? '--',
                                    controller: heightController,
                                    keyBoardType: TextInputType.number,
                                    validator: (value) => null,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      _TextLabel(loc.weight),
                                      SizedBox(width: 4.w),
                                      _TextLabelSmall(loc.kg)
                                    ],
                                  ),
                                  EditprofileTextfield(
                                    hintText: userWeight ?? '--',
                                    controller: weightController,
                                    keyBoardType: TextInputType.number,
                                    validator: (value) => null,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        _TextLabel(loc.gender),
                        Row(
                          children: [loc.male, loc.female].map((g) {
                            return Expanded(
                                child: Padding(
                              padding: REdgeInsets.symmetric(horizontal: 5),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: selectedGender == g
                                          ? ColorsManager.blue3
                                          : ColorsManager.white,
                                      foregroundColor: selectedGender == g
                                          ? ColorsManager.white
                                          : ColorsManager.black,
                                      side: const BorderSide(
                                          color: ColorsManager.blue2),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    setState(() {
                                      selectedGender = g;
                                    });
                                  },
                                  child: Text(g)),
                            ));
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h),
                  SizedBox(
                    width: 200.w,
                    child: ElevatedButtonDesign(
                      text: loc.save,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          updateUserData();
                        }
                      },
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

  Future<void> updateUserData() async {
    final loc = AppLocalizations.of(context)!;

    setState(() {
      isLoading = true;
    });

    DialogUtils.showLoading(context, message: loc.loading);

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firestore = FirebaseFirestore.instance;
      DocumentReference userDoc = firestore.collection(UserDM.collectionName).doc(user.uid);

      try {
        DocumentSnapshot userSnapshot = await userDoc.get();
        if (userSnapshot.exists) {
          UserDM userDM = UserDM.fromFireStore(userSnapshot.data() as Map<String, dynamic>);

          Map<String, dynamic> updatedData = {};
          bool isUpdated = false;

          // التحقق من التغييرات
          if (nameController.text != userDM.fullName) {
            updatedData['fullName'] = nameController.text;
            isUpdated = true;
          }
          if (emailController.text != userDM.email) {
            updatedData['email'] = emailController.text;
            isUpdated = true;
          }
          if (phoneNumController.text != userDM.phoneNumber) {
            updatedData['phoneNumber'] = phoneNumController.text;
            isUpdated = true;
          }
          if (heightController.text != userDM.height?.toString()) {
            updatedData['height'] = double.tryParse(heightController.text);
            isUpdated = true;
          }
          if (weightController.text != userDM.weight?.toString()) {
            updatedData['weight'] = double.tryParse(weightController.text);
            isUpdated = true;
          }

          if (dayController.text != userDM.day) {
            updatedData['day'] = dayController.text;
            isUpdated = true;
          }
          if (monthController.text != userDM.month) {
            updatedData['month'] = monthController.text;
            isUpdated = true;
          }
          if (yearController.text != userDM.year) {
            updatedData['year'] = yearController.text;
            isUpdated = true;
          }
          if (selectedGender != userDM.gender) {
            updatedData['gender'] = selectedGender;
            isUpdated = true;
          }

          // معالجة تاريخ الميلاد والعمر
          String? age;
          if (dayController.text.isNotEmpty &&
              monthController.text.isNotEmpty &&
              yearController.text.isNotEmpty) {
            try {
              DateTime birthDate = DateTime(
                int.parse(yearController.text),
                int.parse(monthController.text),
                int.parse(dayController.text),
              );

              age = calculateAge(birthDate).toString();
              calculatedAge = age;

              Timestamp? oldBirthTimestamp = userDM.birthDate;
              DateTime? oldBirthDate = oldBirthTimestamp?.toDate();

              if (oldBirthDate == null || oldBirthDate != birthDate) {
                updatedData['birthDate'] = Timestamp.fromDate(birthDate);
                updatedData['age'] = age;
                isUpdated = true;
              }
            } catch (_) {
              // تجاهل الخطأ
            }
          } else {
            updatedData['age'] = null;
            updatedData['birthDate'] = null;
            isUpdated = true;
          }

          if (isUpdated) {
            await userDoc.update(updatedData);
            DialogUtils.hide(context);
            DialogUtils.showMessage(
              context,
              title: loc.updateSuccess,
              posActionTitle: loc.ok,
              posAction: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesManager.home,
                      (route) => false,
                  arguments: 3,
                );
              },
            );
          } else {
            DialogUtils.hide(context);
            DialogUtils.showMessage(context, title: loc.noChanges);
          }
        }
      } catch (e) {
        DialogUtils.hide(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${loc.updateFailed}: $e')),
        );
      }
    }

    setState(() {
      isLoading = false;
    });
  }

}
