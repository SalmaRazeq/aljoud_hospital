import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../l10n/app_localizations.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.faq,
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetsManager.faqBg,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.7),
          ),
          SafeArea(
            child: Padding(
              padding: REdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFAQItem(
                      loc.faq1Q,
                      loc.faq1A,
                    ),
                    _buildFAQItem(
                      loc.faq2Q,
                      loc.faq2A,
                    ),
                    _buildFAQItem(
                      loc.faq3Q,
                      loc.faq3A,
                    ),
                    _buildFAQItem(
                      loc.faq4Q,
                      loc.faq4A,
                    ),
                    _buildFAQItem(
                      loc.faq5Q,
                      loc.faq5A,
                    ),
                    _buildFAQItem(
                      loc.faq6Q,
                      loc.faq6A,
                    ),
                    _buildFAQItem(
                      loc.faq7Q,
                      loc.faq7A,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(
    String qustion,
    String answer,
  ) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 12.h),
      Text(
        qustion,
        style: GoogleFonts.inter(
            color: ColorsManager.black,
            fontWeight: FontWeight.w600,
            fontSize: 13),
      ),
      SizedBox(height: 7.h),
      Text(
        answer,
        style: GoogleFonts.inter(
            color: ColorsManager.darkGray,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400),
      ),
      SizedBox(height: 10.h),
      Divider(
        indent: 40.w,
        endIndent: 40.w,
        color: ColorsManager.hint,
      )
    ]);
  }
}
