import 'dart:io';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/widget/profile_details.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/widget/profile_tabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/doctor/doctor_model.dart';
import '../../../../data/models/user_dm.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/language_provider.dart';
import '../../../../providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
    });
  }

  Future<void> _showImageOptions() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          title: Text('Edit Profile Picture',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16.sp,
                  color: Theme.of(context).colorScheme.primaryFixed)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_imageFile != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: Text('Remove Image'),
                  onTap: () {
                    Navigator.pop(context);
                    _removeImage();
                  },
                ),
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.blue),
                title: Text('Pick from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String? userName;
  String userAge = '--';
  String userHeight = '--';
  String userWeight = '--';

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

      DocumentSnapshot userDoc =
      await firestore.collection(UserDM.collectionName).doc(user.uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        UserDM userDM =
        UserDM.fromFireStore(userDoc.data() as Map<String, dynamic>);
        if (userDM.fullName != null && userDM.fullName!.isNotEmpty) {
          userName = userDM.fullName;
        }

        // تعيين القيم الافتراضية فقط إذا كانت null أو فارغة
        setState(() {
          userAge = userDM.age?.isNotEmpty ?? false ? userDM.age.toString() : '';
          userHeight = userDM.height?.isNotEmpty ?? false ? userDM.height.toString() : '';
          userWeight = userDM.weight?.isNotEmpty ?? false ? userDM.weight.toString() : '';
        });
      } else {
        DocumentSnapshot doctorDoc =
        await firestore.collection(DoctorModel.collectionName).doc(user.uid).get();

        if (doctorDoc.exists && doctorDoc.data() != null) {
          DoctorModel doctor =
          DoctorModel.fromFirestore(doctorDoc);
          if (doctor.doctorName != null && doctor.doctorName!.isNotEmpty) {
            userName = "Dr. ${doctor.doctorName}";
          }
        }
      }
      setState(() {}); // تحديث واجهة المستخدم بعد تحميل البيانات
    }
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context)!;
    var langProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isLightTheme() ? Colors.blue.shade700 : ColorsManager.blue,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child:
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
                  child: Column(
                    children: [
                      Align(
                        alignment: langProvider.currentLanguage == 'ar'
                            ? Alignment.topRight // المحاذاة لليمين إذا كانت اللغة عربية
                            : Alignment.topLeft,                        child: Text(loc.profile,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 20.sp,
                                color: Theme.of(context).colorScheme.primary)),
                      ),
                      SizedBox(height: 10.h,),
            
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundColor: ColorsManager.lightGray, // اللون الخلفي للصورة الفارغة
                            backgroundImage: _imageFile != null
                                ? FileImage(_imageFile!) // عرض الصورة إذا كانت موجودة
                                : null,
                            child: _imageFile == null
                                ? Icon(
                              Icons.person,
                              size: 60.sp,
                              color: ColorsManager.darkGray,
                            )
                                : null,
                          ),
                          Container(
                            height: 34.h,
                            width: 34.w,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: ColorsManager.white,
                              shape: BoxShape.circle
                            ),
                            child: IconButton(
                              icon: Icon(Icons.edit, color: ColorsManager.hint, size: 20.sp),
                              onPressed:  _showImageOptions, // عند الضغط يتم استدعاء دالة تغيير الصورة
                              tooltip: 'Edit Profile Picture',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9.h,),
            
                      Text(userName ?? '...', style: GoogleFonts.sourceSerif4(fontSize: 20.sp, color: ColorsManager.white, fontWeight: FontWeight.w500 ),)
                    ],
                  ),)
                ),
            
            Expanded(
              flex: 5,
              child: InnerShadow(
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
                child: Container(
                  height: height * 0.51,
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: Offset(0, 7),
                      ),
                    ],
                    color: themeProvider.isLightTheme() ? ColorsManager.white : ColorsManager.darkBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  padding: REdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Column(
            
                      children: [
                        ProfileDetailsWidget(
                          age: userAge,
                          height: userHeight,
                          weight: userWeight,
                        ),
                        SizedBox(height: 40.h,),
                        ProfileTabs(
                          onTap: (){
                            Navigator.pushNamed(context, RoutesManager.editProfile);
                          },
                          text: loc.editProfile, icon: Icons.edit_outlined,
                        ),
                        ProfileTabs(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesManager.forgetPassword);
                          },
                          text: loc.changePassword, icon: Icons.lock_open_rounded,
                        ),
                        ProfileTabs(
                          onTap: (){
                            Navigator.pushNamed(context, RoutesManager.settingScreen);
                          },
                          text: loc.settings, icon: Icons.settings_outlined,
                        ),
            
                        SizedBox(height: 10.h,),
            
                        InkWell(
                          onTap: () async {
                            try {
                              await FirebaseAuth.instance.signOut();
                               Navigator.pushReplacementNamed(context, RoutesManager.login);
                            } catch (e) {
                              print("Error signing out: $e");
                            }
                          },
                          child: Row(
                            children: [
                              Transform.rotate(
                                angle: 3.14,
                                child: const Icon(Icons.exit_to_app_outlined, color: Colors.red),
                              ),
                              SizedBox(width: 15.w,),
                              Text(loc.logOut,
                                style: GoogleFonts.sourceSerif4(fontSize: 17.sp, color: ColorsManager.blue, fontWeight: FontWeight.w600 ),),
                            ],
                          ),
                        )
            
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}