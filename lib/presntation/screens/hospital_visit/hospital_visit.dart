import 'package:aljoud_hospital/presntation/screens/doctor_profile/doctor_profile.dart';
import 'package:aljoud_hospital/presntation/screens/hospital_visit/widgets/available_days_widget.dart';
import 'package:aljoud_hospital/presntation/screens/hospital_visit/widgets/localization_extension.dart';
import 'package:aljoud_hospital/presntation/screens/hospital_visit/widgets/meeting_type.dart';
import 'package:aljoud_hospital/presntation/screens/patient_details/patient_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/color_manager.dart';
import '../../../data/models/doctor/doctor_model.dart';
import '../../../l10n/app_localizations.dart';
import '../see_all/category_details/CategoryDetailsScreen.dart';

class HospitalVisitScreen extends StatefulWidget {
  final Doctor doctor;

  const HospitalVisitScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  State<HospitalVisitScreen> createState() => _HospitalVisitScreenState();
}

class _HospitalVisitScreenState extends State<HospitalVisitScreen> {
  String selectedDay = "today";
  String? selectedTime;
  String? selectedType = 'Online';

  final Map<String, Map<String, List<String>>> visitSlots = {
    "today": {
      "morning": ["09:45 AM", "10:00 AM", "10:15 AM", "11:00 AM"],
      "evening": ["05:00 PM"],
      "night": ["08:00 PM", "08:30 PM"],
    },
    "tomorrow": {
      "morning": ["09:00 AM", "09:45 AM", "10:15 AM", "11:00 AM"],
      "evening": ["04:00 PM", "05:00 PM"],
      "night": [],
    },
    "dayAfterTomorrow": {
      "morning": ["08:30 AM", "09:30 AM"],
      "evening": ["04:30 PM", "05:30 PM"],
      "night": ["08:00 PM"],
    },
    "dayAfterAfterTomorrow": {
      "morning": ["10:00 AM"],
      "evening": [],
      "night": [],
    },
  };


  @override
  Widget build(BuildContext context) {

    final today = DateTime.now();
    final loc = AppLocalizations.of(context)!;

    final formattedDate = '${loc.today}, ${today.day} ${_getMonthName(today.month)}';
    final tomorrow = today.add(const Duration(days: 1));
    final formattedTomorrow = _getFormattedDate(tomorrow);
    final dayAfterTomorrow = today.add(const Duration(days: 2));
    final formattedDayAfterTomorrow = _getFormattedDate(dayAfterTomorrow);
    final dayAfterAfterTomorrow = today.add(const Duration(days: 3));
    final formattedDayAfterAfterTomorrow = _getFormattedDate(dayAfterAfterTomorrow);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: REdgeInsets.all(8),
                color: ColorsManager.blue3.withOpacity(0.8),
                height: 80.h,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_rounded, color: ColorsManager.white, size: 26.sp),
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      loc.hospitalVisitSchedule,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18.sp, color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: REdgeInsets.only(left: 13.w,right: 13.w, top: 14.h, bottom: 5.h),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    children: [
                      InkWell(
                        onTap : (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => DoctorProfileScreen(doctor: widget.doctor))
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: Image.asset(widget.doctor.image, height: 45.h, width: 45.w, fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      InkWell(
                        onTap : (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorProfileScreen(doctor: widget.doctor))
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(widget.doctor.name, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14.sp)),
                                SizedBox(width: 8.w),
                                Icon(Icons.arrow_forward_ios, size: 12.sp, color: ColorsManager.blue2,)
                              ],
                            ),
                            Text(widget.doctor.specialty, style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSecondary)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(Icons.attach_money_rounded, size: 18.sp, color: Theme.of(context).colorScheme.primaryFixed,),
                          Text(widget.doctor.price, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Padding(padding: REdgeInsets.symmetric(horizontal: 8.w), child: Divider(thickness: 0.5.w)),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 4.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      AvailableDaysWidget(
                        date: formattedDate,
                        slots: '${_getTotalSlots("today")} ${loc.slotsAvailable}',
                        isSelected: selectedDay == "today",
                        onTap: () => setState(() { selectedDay = "today"; selectedTime = null; }),
                      ),
                      SizedBox(width: 6.w),
                      AvailableDaysWidget(
                        date: formattedTomorrow,
                        slots: '${_getTotalSlots("tomorrow")} ${loc.slotsAvailable}',
                        isSelected: selectedDay == "tomorrow",
                        onTap: () => setState(() { selectedDay = "tomorrow"; selectedTime = null; }),
                      ),
                      SizedBox(width: 6.w),
                      AvailableDaysWidget(
                        date: formattedDayAfterTomorrow,
                        slots: '${_getTotalSlots("dayAfterTomorrow")} ${loc.slotsAvailable}',
                        isSelected: selectedDay == "dayAfterTomorrow",
                        onTap: () => setState(() { selectedDay = "dayAfterTomorrow"; selectedTime = null; }),
                      ),
                      SizedBox(width: 6.w),
                      AvailableDaysWidget(
                        date: formattedDayAfterAfterTomorrow,
                        slots: '${_getTotalSlots("dayAfterAfterTomorrow")} ${loc.slotsAvailable}',
                        isSelected: selectedDay == "dayAfterAfterTomorrow",
                        onTap: () => setState(() { selectedDay = "dayAfterAfterTomorrow"; selectedTime = null; }),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),
              Center(
                child: Text(
                  _getReadableSelectedDay(selectedDay),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primaryFixed),
                ),
              ),

              SizedBox(height: 6.h),
              MeetingType(onSelected: (type) => setState(() => selectedType = type)),

              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var period in ["morning", "evening", "night"])
                      if (visitSlots[selectedDay] != null && (visitSlots[selectedDay]![period]?.isNotEmpty ?? false)) ...[
                        Text('${AppLocalizations.of(context)!.translate(period)} ${visitSlots[selectedDay]![period]!.length} ${loc.slots}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp)),
                        Wrap(
                          spacing: 6,
                          children: visitSlots[selectedDay]![period]!.map((time) {
                            return ChoiceChip(
                              backgroundColor: ColorsManager.lightGray,
                              selectedColor: ColorsManager.fadedBlue3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                              labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: ColorsManager.black),
                              label: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(time)),
                              selected: selectedTime == time,
                              onSelected: (val) => setState(() => selectedTime = time),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16.h),
                      ]
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              if (selectedTime != null)
                Padding(
                  padding: REdgeInsets.only(bottom: 24.h),
                  child: Center(
                    child: SizedBox(
                      width: 200.w,
                      child: ElevatedButton(
                        onPressed: () {
                          final selectedDoctor = DoctorModel(
                            doctorName: widget.doctor.name,
                            specialty: widget.doctor.specialty,
                            date: _getReadableSelectedDay(selectedDay),
                            time: selectedTime!,
                            price: widget.doctor.price,
                            image: widget.doctor.image,
                            meetingType: selectedType,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientDetailsScreen(
                                doctor: selectedDoctor,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: REdgeInsets.symmetric(vertical: 6.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        ),
                        child: Text(loc.continueText, style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    final loc = AppLocalizations.of(context)!;
    const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
    return loc.translate(months[month - 1]);
  }

  int _getTotalSlots(String dateKey) {
    final dayData = visitSlots[dateKey];
    if (dayData == null) return 0;
    return dayData.values.fold(0, (total, slots) => total + slots.length);
  }

  String _getFormattedDate(DateTime date) {
    return '${_getDayOfWeek(date.weekday)}, ${date.day} ${_getMonthName(date.month)}';
  }

  String _getDayOfWeek(int weekday) {
    final loc = AppLocalizations.of(context)!;
    const days = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
    return loc.translate(days[weekday - 1]);
  }

  String _getReadableSelectedDay(String key) {
    final now = DateTime.now();
    switch (key) {
      case "today":
        return '${AppLocalizations.of(context)!.today}, ${now.day} ${_getMonthName(now.month)}';
      case "tomorrow":
        final date = now.add(const Duration(days: 1));
        return '${AppLocalizations.of(context)!.tomorrow}, ${date.day} ${_getMonthName(date.month)}';
      case "dayAfterTomorrow":
        final date = now.add(const Duration(days: 2));
        return '${_getDayOfWeek(date.weekday)}, ${date.day} ${_getMonthName(date.month)}';
      case "dayAfterAfterTomorrow":
        final date = now.add(const Duration(days: 3));
        return '${_getDayOfWeek(date.weekday)}, ${date.day} ${_getMonthName(date.month)}';
      default:
        return key;
    }
  }

}
