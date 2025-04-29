import 'dart:io';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/widget/circleButton.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/widget/profile_details.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/widget/profile_tabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/doctor_model.dart';
import '../../../../data/models/user_dm.dart';
import '../../../../l10n/app_localizations.dart';

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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          title: Text('Edit Profile Picture',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.sp)),
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
      } else {

        DocumentSnapshot doctorDoc =
        await firestore.collection(DoctorModel.collectionName).doc(user.uid).get();

        if (doctorDoc.exists && doctorDoc.data() != null) {
          DoctorModel doctor =
          DoctorModel.fromFirestore(doctorDoc); // تعديل هنا عشان يستخدم الـ factory
          if (doctor.doctorName != null && doctor.doctorName!.isNotEmpty) {
            userName = "Dr. ${doctor.doctorName}";
          }
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade700,
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child:
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 14.w, vertical: 25.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Profile',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 22.sp,
                                  color: Theme.of(context).colorScheme.primary)),
                          const Spacer(),
                          ProfileCircleButton(
                              icon: Icons.search_rounded,
                              onTap: () {}),
                        ],
                      ),
                      SizedBox(height: 5.h,),
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
                      SizedBox(height: 10.h,),

                      Text('${userName ?? '...'}',)
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
                    offset: const Offset(0, -4), // سحب الشادو للأعلى
                  ),
                ],
                child: Container(
                  height: height * 0.53,
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
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  padding: REdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Column(

                      children: [
                        ProfileDetailsWidget(),
                        SizedBox(height: 40.h,),
                        ProfileTabs(
                          onTap: (){},
                          text: 'Edit profile', icon: Icons.edit_outlined,
                        ),
                        ProfileTabs(
                          onTap: (){},
                          text: 'Change password', icon: Icons.lock_open_rounded,
                        ),
                        ProfileTabs(
                          onTap: (){},
                          text: 'Settings', icon: Icons.settings_outlined,
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
                              Text('Log out',
                                style: GoogleFonts.sourceSerif4(fontSize: 16.sp, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w400 ),),
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