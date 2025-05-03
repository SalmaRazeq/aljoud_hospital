import "package:aljoud_hospital/core/utils/color_manager.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../../../../providers/language_provider.dart";

class LanguageBotoomSheet extends StatefulWidget {
  const LanguageBotoomSheet({super.key});

  @override
  State<LanguageBotoomSheet> createState() => _LanguageBotoomSheetState();
}

class _LanguageBotoomSheetState extends State<LanguageBotoomSheet> {
  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LanguageProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.5.h,
      padding: REdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => _selectLanguage('en', langProvider),
            child: langProvider.currentLanguage == 'en'
                ? theSelectedLanguage("English")
                : theUnSelectedLanguage("English"),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => _selectLanguage('ar', langProvider),
            child: langProvider.currentLanguage == 'ar'
                ? theSelectedLanguage("العربية")
                : theUnSelectedLanguage("العربية"),
          ),
        ],
      ),
    );
  }

  Future<void> _selectLanguage(String langCode, LanguageProvider langProvider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', langCode);
    langProvider.changeAppLanguage(langCode);
    Navigator.pop(context, langCode); // يرجع القيمة إلى SettingScreen
  }

  Widget theSelectedLanguage(String selectedLanguage) {
    return Row(
      children: [
        Text(
          selectedLanguage,
          style: GoogleFonts.inter(fontSize: 20.sp, ),
        ),
        const Spacer(),
        const Icon(
          Icons.check,
          size: 30,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget theUnSelectedLanguage(String unSelectedLanguage) {
    return Row(
      children: [
        Text(
          unSelectedLanguage,
          style: GoogleFonts.inter(fontSize: 18.sp, color: ColorsManager.black),
        ),
      ],
    );
  }
}
