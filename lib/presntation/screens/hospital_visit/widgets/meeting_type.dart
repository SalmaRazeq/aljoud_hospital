import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/color_manager.dart';

class MeetingType extends StatefulWidget {
  final Function(String)? onSelected;

  const MeetingType({super.key, this.onSelected});

  @override
  State<MeetingType> createState() => _MeetingTypeState();
}

class _MeetingTypeState extends State<MeetingType> {
  String? selectedAppointmentType ;


  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final appointmentTypes = [loc.online, loc.inPerson];
    selectedAppointmentType ??= appointmentTypes.first;

    return Padding(
      padding: REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.appointmentType,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500, fontSize: 14.sp
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: List.generate(appointmentTypes.length, (index) {
              final type = appointmentTypes[index];
              return Padding(
                padding: REdgeInsets.only(left: 6.w, right: 6.w),
                child: ChoiceChip(
                  backgroundColor: ColorsManager.lightGray,
                  selectedColor: ColorsManager.fadedBlue3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  label: Text(
                    type,
                    style: GoogleFonts.sourceSans3(
                      color: selectedAppointmentType == type
                          ? ColorsManager.blue
                          : ColorsManager.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp
                    ),
                  ),
                  selected: selectedAppointmentType == type,
                  onSelected: (_) {
                    setState(() {
                      selectedAppointmentType = type;
                    });
                    // إرسال النوع المختار إلى الخارج
                    widget.onSelected?.call(type);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
