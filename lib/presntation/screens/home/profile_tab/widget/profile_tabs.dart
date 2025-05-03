import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/theme_provider.dart';

class ProfileTabs extends StatelessWidget {
  ProfileTabs({super.key, required this.text, required this.icon, required this.onTap});
  IconData icon;
  String text;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: REdgeInsets.only(bottom: 6.h, top: 12.h),
              child: Row(
                children: [
                  Icon(icon, color: themeProvider.isLightTheme() ? ColorsManager.black : ColorsManager.blue),
                  SizedBox(width: 15.w,),
                  Text(text,
                    style: GoogleFonts.sourceSerif4(fontSize: 16.sp, color: Theme.of(context).colorScheme.primaryFixed, fontWeight: FontWeight.w400 ),),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded, color: Theme.of(context).colorScheme.onSecondary, size: 13.sp,)
                ],
              ),
            ),
             Divider(thickness: 0.3, color: Theme.of(context).colorScheme.primaryFixed,),
          ],
        ),
      );
  }
}
