import 'package:aljoud_hospital/core/utils/assets_manager.dart';
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.asset(
                          AssetsManager.admin,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 30.h,),
                      _buildListTitle(
                          icon: FontAwesomeIcons.add,
                          title: loc.insertDoctor,
                          iconColor: ColorsManager.lightGreen.withOpacity(0.8),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesManager.insertDoctor);
                          }),
                      SizedBox(height: 10.h),

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
