import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../providers/language_provider.dart';
import '../../../../../providers/theme_provider.dart';
import '../../../widgets/build_circleButton.dart';
import 'language_bottomSheet/language_bottom_sheet.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = false;
  String selectedLanguage = 'en';
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    loadPreferences();
  }
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    selectedLanguage = prefs.getString('selectedLanguage') ?? 'en';

    var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    await themeProvider.getTheme();

    setState(() {
      isDarkMode = themeProvider.currentTheme == ThemeMode.dark;
      isLoading = false; // انتهى التحميل
    });

    var langProvider = Provider.of<LanguageProvider>(context, listen: false);
    langProvider.getLang();
  }


  void toggleDarkMode(bool value) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final newTheme = value ? ThemeMode.dark : ThemeMode.light;
    themeProvider.changeAppTheme(newTheme);
    setState(() {
      isDarkMode = value;
    });
  }


  // الانتقال إلى إعدادات اللغة
  void showLanguageBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => const LanguageBotoomSheet(),
    );

    if (result != null && (result == 'en' || result == 'ar')) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        selectedLanguage = result;
      });
      await prefs.setString('selectedLanguage', selectedLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: REdgeInsets.symmetric(vertical: 20.h,),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 15.h,),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutesManager.home, (route) => false, arguments: 3,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: themeProvider.isLightTheme() ? ColorsManager.black : ColorsManager.white,

                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            loc.settings,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 24.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w)
                    ],
                  ),
                ),
                Padding(
                  padding: REdgeInsets.symmetric(vertical: 40, horizontal: 15),
                  child: Column(
                    children: [
                      _buildListTitle(
                        icon: Icons.notifications_none_rounded,
                        title: loc.notification,
                        iconColor: ColorsManager.blue3,
                      ),
                      SizedBox(height: 10.h),
                      _buildListTitle(
                        icon: Icons.dark_mode_outlined,
                        title: loc.darkMode,
                        iconColor: ColorsManager.purple.withOpacity(0.8),
                        trailing: isLoading
                            ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                                child: const CircularProgressIndicator(
                                    strokeWidth: 2),
                              )
                            : Switch(
                          value: isDarkMode,
                          onChanged: toggleDarkMode,
                          activeColor: ColorsManager.purple,
                        ),
                      ),

                      SizedBox(height: 10.h),
                      _buildListTitle(
                        icon: Icons.language,
                        title: loc.language,
                        iconColor: ColorsManager.orange.withOpacity(0.8),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              selectedLanguage == 'ar' ? 'العربية' : 'English',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: ColorsManager.darkGray),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.keyboard_arrow_up_rounded,
                              size: 26.sp,
                              color: ColorsManager.hint,
                            ),
                          ],
                        ),
                        onTap: () async {
                          final result = await showModalBottomSheet(
                            context: context,
                            builder: (context) => const LanguageBotoomSheet(),
                          );

                          if (result != null && result is String) {
                            setState(() {
                              selectedLanguage = result;
                            });

                            // حفظ اللغة المختارة
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('selectedLanguage', selectedLanguage);
                          }
                        },

                      ),
                      SizedBox(height: 10.h),
                      _buildListTitle(
                        icon: FontAwesomeIcons.shieldHalved,
                        title: loc.security,
                        iconColor: ColorsManager.lightGreen.withOpacity(0.8),
                      ),
                      SizedBox(height: 10.h),
                      _buildListTitle(
                        icon: Icons.help_outline,
                        title: loc.help,
                        iconColor: ColorsManager.red.withOpacity(0.8),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ColorsManager.black,
          ),
        ),
        trailing: trailing ??
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey.shade600),
      ),
    );
  }
}
