import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/theme_provider.dart';

class ToggleButtonWidget extends StatefulWidget {
  final bool isPatientSelected;
  final Function(bool) onToggle;

  const ToggleButtonWidget({
    Key? key,
    required this.isPatientSelected,
    required this.onToggle,
  }) : super(key: key);

  @override
  State<ToggleButtonWidget> createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Center(
      child: Container(
        width: 185.w,
        height: 33.h,
        decoration: BoxDecoration(
          color: ColorsManager.lightGray,
          borderRadius: BorderRadius.circular(30.r),
          border: themeProvider.isLightTheme() ? Border.all(color: ColorsManager.hint) : Border.all(color: Colors.transparent),
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => widget.onToggle(true),
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.isPatientSelected ? themeProvider.isLightTheme() ? ColorsManager.blue2 : ColorsManager.darkBlue1 : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(30.r)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    loc.patient,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: widget.isPatientSelected ? ColorsManager.white : ColorsManager.black,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => widget.onToggle(false),
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.isPatientSelected ? Colors.transparent : themeProvider.isLightTheme() ? ColorsManager.blue2 : ColorsManager.darkBlue1,
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(30.r)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    loc.doctor,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: widget.isPatientSelected ? ColorsManager.black : ColorsManager.white,
                      fontSize: 15.sp,
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
