import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../l10n/app_localizations.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 12.w, vertical: 6),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).colorScheme.primaryFixed,
                        size: 22.sp,
                      )),
                  Expanded(
                    child: Center(
                      child: Text(
                        loc.supportSystem,
                        style: GoogleFonts.inter(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primaryFixed,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                elevation: 4,
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    border: Border.all(color: ColorsManager.hint),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    children: [
                      buildOption(text: loc.faqs),
                      buildDivider(),
                      buildOption(
                          icon: Icons.support_agent, text: loc.contactSupport),
                      buildDivider(),
                      buildOption(
                          icon: Icons.email_outlined,
                          text: loc.trackTicketStatus),
                      buildDivider(),
                      buildOption(
                          icon: Icons.menu_book_outlined,
                          text: loc.systemGuide),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOption({
    IconData? icon,
    required String text,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: ColorsManager.fadedBlue3,
        child: icon == null
            ? Text(
                'FAQ',
                style: GoogleFonts.sourceSerif4(
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.blue2,
                  fontSize: 14.sp,
                ),
              )
            : Icon(
                icon,
                color: ColorsManager.blue2,
                size: 20,
              ),
      ),
      title: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: ColorsManager.black,
          fontSize: 16.sp,
        ),
      ),
      onTap: () {},
    );
  }

  Widget buildDivider() {
    return const Divider(
      color: ColorsManager.hint,
      thickness: 0.5,
    );
  }
}
