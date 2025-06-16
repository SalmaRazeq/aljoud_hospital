import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../l10n/app_localizations.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<String> doctors = ['Dr. Ahmed', 'Dr. Salma', 'Dr. Tarek'];
  String? selectedDoctor;
  bool showDropdown = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            loc.admin,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.primaryFixed,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.primaryFixed, size: 22),
        ),
        body: SafeArea(
          child: Container(
            padding: REdgeInsets.symmetric(
              vertical: 20.h,
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                    padding:
                        REdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Column(children: [
                      _buildListTitle(
                          icon: FontAwesomeIcons.userDoctor,
                          title: loc.updateDoctor,
                          iconColor: ColorsManager.blue3,
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesManager.updateDoctor);
                          }),
                      SizedBox(height: 10.h),
                      _buildListTitle(
                          icon: FontAwesomeIcons.add,
                          title: loc.insertDoctor,
                          iconColor: ColorsManager.lightGreen.withOpacity(0.8),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesManager.insertDoctor);
                          }),
                      SizedBox(height: 10.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildListTitle(
                            icon: Icons.delete,
                            title: loc.deleteDoctor,
                            iconColor: ColorsManager.red.withOpacity(0.8),
                            trailing: Icon(
                              showDropdown
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              size: 28.sp,
                              color: ColorsManager.hint,
                            ),
                            onTap: () {
                              setState(() {
                                showDropdown = !showDropdown;
                              });
                            },
                          ),
                          if (showDropdown) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedDoctor,
                                    borderRadius: BorderRadius.circular(10),
                                    hint: Text(
                                      loc.selectDoctor,
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: ColorsManager.darkGray,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    items: doctors.map((doctor) {
                                      return DropdownMenuItem<String>(
                                        value: doctor,
                                        child: Text(doctor,
                                            style: GoogleFonts.inter(
                                                fontSize: 13,
                                                color: ColorsManager.darkGray,
                                                fontWeight: FontWeight.w500)),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedDoctor = value;
                                        // منخليش showDropdown = false علشان الزر يفضل ظاهر
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            if (selectedDoctor != null)
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16.w, right: 16.w, top: 8.h),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsManager.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 12),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      doctors.remove(selectedDoctor);
                                      selectedDoctor = null;
                                      showDropdown = false;
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(loc.deleteSuccess),
                                        backgroundColor: ColorsManager.red,
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: ColorsManager.white,
                                    size: 20,
                                  ),
                                  label: Text(
                                    loc.confirmDelete,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13.sp),
                                  ),
                                ),
                              ),
                          ],
                        ],
                      )
                    ])),
              ]),
            ),
          ),
        ));
  }

  Widget _buildListTitle({
    required IconData icon,
    required String title,
    Color? iconColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: iconColor?.withOpacity(0.2) ?? ColorsManager.fadedBlue3,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor ?? ColorsManager.blue3),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: ColorsManager.black,
          ),
        ),
        trailing: trailing ??
            Icon(Icons.arrow_forward_ios,
                size: 16.sp, color: Colors.grey.shade600),
      ),
    );
  }
}
