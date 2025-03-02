import 'package:aljoud_hospital/presntation/screens/home/AppBar/search_widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/color_manager.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 15, vertical: 18),
      height: 250.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade800],
        ),
        borderRadius:  BorderRadius.only(
          bottomLeft: Radius.circular(25.r),
          bottomRight: Radius.circular(25.r),
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: ColorsManager.white,
                  child: const Icon(
                    Icons.person_2_outlined,
                    color: ColorsManager.black2,
                    size: 28,
                  ),
                ),
                SizedBox(width: 15.w,),
                Text('${AppLocalizations.of(context)!.hello}Abdelrahman',
                  style: Theme.of(context).textTheme.bodyMedium
                ),
              ],
            ),
            SizedBox(height: 25.h,),
            Padding(
              padding: REdgeInsets.only(left: 8.0),
              child: Text(
                  AppLocalizations.of(context)!.findYourDoctor,
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
            SizedBox( height: 22.h,),
            SearchWidget(),
          ]),
    );
  }
}
