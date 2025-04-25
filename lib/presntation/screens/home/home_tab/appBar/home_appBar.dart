
import 'package:aljoud_hospital/presntation/screens/home/home_tab/AppBar/search_widget/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../data/models/user_dm.dart';
import '../../../../../l10n/app_localizations.dart';


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
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(UserDM.collectionName)
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        UserDM userDM = UserDM.fromFireStore(userDoc.data() as Map<String, dynamic>);

        if (userDM.fullName != null && userDM.fullName!.isNotEmpty) {
          List<String> nameParts = userDM.fullName!.split(" ");
          userName = nameParts[0];
        }
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.only(right: 15.w, left: 15.w, top: 25.h, bottom: 18.h),
      height: 230.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade800],
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
                onPressed: () {},
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
