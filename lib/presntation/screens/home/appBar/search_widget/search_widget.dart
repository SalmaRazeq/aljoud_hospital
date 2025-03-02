import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color
            blurRadius: 10, // Blur intensity
            spreadRadius: 2, // Spread of shadow
            offset: const Offset(4, 4), // X, Y offset
          ),
        ],
      ),
      child: SizedBox(
        height: 50,
        child: TextField(
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.search,
            hintStyle: GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w600 ,color: Theme.of(context).colorScheme.shadow),
            filled: true,
            isDense: true,
            fillColor: Theme.of(context).colorScheme.primary,
            contentPadding: REdgeInsets.symmetric(vertical: 14, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            suffixIcon: Padding(
              padding: REdgeInsets.all(8),
              child: Icon(
                Icons.search,
                size: 22.sp,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),


          ),
        ),
      ),
    );
  }
}
