import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/home/home_tab/home_appBar/search_widget/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../data/models/doctor/doctor_model.dart';
import '../../../../../data/models/user_dm.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../providers/theme_provider.dart';

class HomeAppBar extends StatefulWidget {
   HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
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
      await firestore.collection('Users').doc(user.uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        UserDM userDM =
        UserDM.fromFireStore(userDoc.data() as Map<String, dynamic>);
        if (userDM.fullName != null && userDM.fullName!.isNotEmpty) {
          List<String> nameParts = userDM.fullName!.split(" ");
          userName = nameParts[0];
        }
      } else {

        DocumentSnapshot doctorDoc =
        await firestore.collection('Doctors').doc(user.uid).get();

        if (doctorDoc.exists && doctorDoc.data() != null) {
          DoctorModel doctor =
          DoctorModel.fromFirestore(doctorDoc); // تعديل هنا عشان يستخدم الـ factory
          if (doctor.doctorName != null && doctor.doctorName!.isNotEmpty) {
            List<String> nameParts = doctor.doctorName!.split(" ");
            userName = "Dr. ${nameParts[0]}";
          }
        }
      }

      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      padding: REdgeInsets.only(right: 15.w, left: 15.w, top: 45.h, bottom: 18.h),
      height: 240.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: themeProvider.isLightTheme()
              ? [Colors.blue.shade700, Colors.blue.shade900]
              : [Colors.blue.shade900, const Color(0xFF003060)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.r),
          bottomRight: Radius.circular(25.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: ColorsManager.white,
                child: Icon(
                  Icons.person_2_outlined,
                  color: ColorsManager.darkGray,
                  size: 26.sp,
                ),
              ),
              SizedBox(width: 15.w),
              Text(
                '${AppLocalizations.of(context)!.hello} ${userName ?? '...'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesManager.notification);
                },
                icon: Icon(Icons.notifications, color: Theme.of(context).colorScheme.primary, size: 24.sp),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: REdgeInsets.only(left: 8.0),
            child: Text(
              AppLocalizations.of(context)!.findYourDoctor,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 10.h),
          SearchWidget(),
        ],
      ),
    );
  }
}
