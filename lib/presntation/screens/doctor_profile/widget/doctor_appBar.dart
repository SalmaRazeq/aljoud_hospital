import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/theme_provider.dart';
import '../../widgets/build_circleButton.dart';

class DoctorAppBar extends StatelessWidget {
  const DoctorAppBar ({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      padding: REdgeInsets.all(8),
      color: themeProvider.isLightTheme() ? ColorsManager.blue2 : ColorsManager.darkBlue1,
      height: 90.h,
      child: Row(
        children: [
          BuildCircleButton(
              icon: Icons.arrow_back_ios_new_outlined,
              onTap: () {
                Navigator.pop(context);
              }),
          Expanded(
            child: Center(
              child: Text(
                loc.doctorProfile,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 20.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 40.w),
        ],
      ),

    );
  }
}
