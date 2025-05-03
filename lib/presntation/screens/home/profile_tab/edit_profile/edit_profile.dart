import 'package:aljoud_hospital/core/utils/dialog_utils/dialog_utils.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/auth/forget_password/widgets/elevated_button.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/edit_profile/widget/editProfile_textField.dart';
import 'package:aljoud_hospital/presntation/screens/widgets/build_circleButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/email_validation.dart';
import '../../../../../data/models/user_dm.dart';
import '../../../../../l10n/app_localizations.dart';

class EditeProfileScreen extends StatefulWidget {
   EditeProfileScreen({super.key});

  @override
  State<EditeProfileScreen> createState() => _EditeProfileScreenState();
}

class _EditeProfileScreenState extends State<EditeProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController ageController = TextEditingController();
   TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? userName, userPhone, userEmail, userAge, userHeight, userWeight;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserName();
    });
  }

  Future<void> loadUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firestore = FirebaseFirestore.instance;

      DocumentSnapshot userDoc = await firestore.collection(UserDM.collectionName).doc(user.uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        // قم بتخزين البيانات في المتغيرات مباشرة
        UserDM userDM = UserDM.fromFireStore(userDoc.data() as Map<String, dynamic>);

        if (userDM.fullName != null) nameController.text = userDM.fullName!;
        if (userDM.email != null) emailController.text = userDM.email!;
        if (userDM.phoneNumber != null) phoneNumController.text = userDM.phoneNumber!;
        if (userDM.age != null) ageController.text = userDM.age!.toString();
        if (userDM.height != null) heightController.text = userDM.height!.toString();
        if (userDM.weight != null) weightController.text = userDM.weight!.toString();


        setState(() {
          userName = userDM.fullName;
          userPhone = userDM.phoneNumber;
          userEmail = userDM.email;
          userAge = userDM.age?.toString();
          userHeight = userDM.height?.toString();
          userWeight = userDM.weight?.toString();
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

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
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
        ),
      );
    }

    return Scaffold(
        body: SafeArea(
          child: Container(
              padding: REdgeInsets.symmetric(vertical: 25, horizontal: 16),
              child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
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
                                        RoutesManager.home, (route) => false, arguments: 3,
                                      );
                                    }),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                        loc.editProfile,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 24.sp)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20.w,)
                              ],
                            ),
                          ),

                          SizedBox(height: 15.h,),

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
                                  validator: (input){
                                    if (input == null || input.length != 11) {
                                      return loc.password11digits;
                                    }
                                    return null;
                                  },
                                  keyBoardType: const TextInputType.numberWithOptions() ,
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

                                _TextLabel(loc.age),
                                EditprofileTextfield(
                                  hintText: userAge ?? '--',
                                  controller: ageController,
                                  validator: (value) => null,
                                  keyBoardType: const TextInputType.numberWithOptions(),),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              _TextLabel(loc.height),
                                              SizedBox(width: 4.w,),
                                              _TextLabelSmall(loc.cm)
                                            ],
                                          ),
                                          EditprofileTextfield(
                                              hintText: userHeight ?? '--',
                                              controller: heightController,
                                              keyBoardType: const TextInputType.numberWithOptions() ,
                                              validator: (value) => null),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20.w,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              _TextLabel(loc.weight),
                                              SizedBox(width: 4.w,),
                                              _TextLabelSmall(loc.kg)
                                            ],
                                          ),
                                          EditprofileTextfield(
                                              hintText: userWeight ?? '--',
                                              controller: weightController,
                                              keyBoardType: const TextInputType.numberWithOptions() ,
                                              validator: (value) => null),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        SizedBox(height: 50.h,),
                          SizedBox(
                            width: 200.w,
                            child: ElevatedButtonDesign(
                                text: loc.save,
                                onTap: (){
                                  if (_formKey.currentState?.validate() ?? false) {
                                    updateUserData();
                                  }

                                }),
                          )
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

    // تفعيل مؤشر التحميل
    setState(() {
      isLoading = true;
    });

    // عرض مؤشر التحميل
    DialogUtils.showLoading(context, message: 'Wait please..');

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firestore = FirebaseFirestore.instance;
      DocumentReference userDoc = firestore.collection(UserDM.collectionName).doc(user.uid);

      try {
        // استرجاع البيانات الحالية
        DocumentSnapshot userSnapshot = await userDoc.get();
        if (userSnapshot.exists) {
          UserDM userDM = UserDM.fromFireStore(userSnapshot.data() as Map<String, dynamic>);

          // تحقق مما إذا كانت البيانات المدخلة قد تغيرت
          bool isUpdated = false;

          if (nameController.text.isNotEmpty && nameController.text != userDM.fullName) {
            isUpdated = true;
          }
          if (emailController.text.isNotEmpty && emailController.text != userDM.email) {
            isUpdated = true;
          }
          if (phoneNumController.text.isNotEmpty && phoneNumController.text != userDM.phoneNumber) {
            isUpdated = true;
          }
          if (ageController.text.isNotEmpty && int.tryParse(ageController.text) != userDM.age) {
            isUpdated = true;
          }
          if (heightController.text.isNotEmpty && double.tryParse(heightController.text) != userDM.height) {
            isUpdated = true;
          }
          if (weightController.text.isNotEmpty && double.tryParse(weightController.text) != userDM.weight) {
            isUpdated = true;
          }

          // إذا كانت البيانات قد تغيرت، قم بتحديث البيانات في Firestore
          if (isUpdated) {
            await userDoc.update({
              'fullName': nameController.text.isNotEmpty ? nameController.text : userDM.fullName,
              'email': emailController.text.isNotEmpty ? emailController.text : userDM.email,
              'phoneNumber': phoneNumController.text.isNotEmpty ? phoneNumController.text : userDM.phoneNumber,
              'age': ageController.text.isNotEmpty ? int.tryParse(ageController.text) : userDM.age,
              'height': heightController.text.isNotEmpty ? double.tryParse(heightController.text) : userDM.height,
              'weight': weightController.text.isNotEmpty ? double.tryParse(weightController.text) : userDM.weight,
            }
            );
            // إخفاء مؤشر التحميل وعرض رسالة تأكيد
            DialogUtils.hide(context);
            DialogUtils.showMessage(context,
              title: 'Data updated successfully',
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
            // إخفاء مؤشر التحميل وعرض رسالة عدم وجود تغييرات
            DialogUtils.hide(context);
            DialogUtils.showMessage(context, title: 'No changes detected');
          }
        }
      } catch (e) {
        // في حالة حدوث خطأ أثناء استرجاع البيانات أو التحديث
        DialogUtils.hide(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update data: $e')));
      }
    }

    // إيقاف مؤشر التحميل
    setState(() {

      isLoading = false;
    });
  }


}