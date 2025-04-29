import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/hospital_visit/widgets/available_days_widget.dart';
import 'package:aljoud_hospital/presntation/screens/hospital_visit/widgets/choice_chip.dart';
import 'package:aljoud_hospital/presntation/screens/patient_details/patient_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/color_manager.dart';
import '../../../data/models/doctor_model.dart';
import '../see_all/category_details/CategoryDetailsScreen.dart';
import '../widgets/build_circleButton.dart';

class HospitalVisitScreen extends StatefulWidget {
  final Doctor doctor;

  const HospitalVisitScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  State<HospitalVisitScreen> createState() => _HospitalVisitScreenState();
}

class _HospitalVisitScreenState extends State<HospitalVisitScreen> {
  String selectedDay = "Today";
  String? selectedTime;


  final Map<String, Map<String, List<String>>> visitSlots = {
    "today": {
      "Morning": ["09:45 AM", "10:00 AM", "10:15 AM", "11:00 AM"],
      "Evening": ["05:00 PM"],
      "Night": ["08:00 PM", "08:30 PM"],
    },
    "tomorrow": {
      "Morning": ["09:00 AM", "09:45 AM", "10:15 AM", "11:00 AM"],
      "Evening": ["04:00 PM", "05:00 PM"],
      "Night": [],
    },
    "dayAfterTomorrow": {
      "Morning": ["08:30 AM", "09:30 AM"],
      "Evening": ["04:30 PM", "05:30 PM"],
      "Night": ["08:00 PM"],
    },
    "dayAfterAfterTomorrow": {
      "Morning": ["10:00 AM"],
      "Evening": [],
      "Night": [],
    },
  };

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final formattedDate = 'Today, ${today.day} ${_getMonthName(today.month)}';
    final tomorrow = today.add(const Duration(days: 1));
    final formattedTomorrow = _getFormattedDate(tomorrow);
    final dayAfterTomorrow = today.add(const Duration(days: 2));
    final formattedDayAfterTomorrow = _getFormattedDate(dayAfterTomorrow);
    final dayAfterAfterTomorrow = today.add(const Duration(days: 3));
    final formattedDayAfterAfterTomorrow = _getFormattedDate(dayAfterAfterTomorrow);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: REdgeInsets.all(8),
                color: ColorsManager.blue3.withOpacity(0.8),
                height: 80.h,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // BuildCircleButton(
                    //   icon: Icons.arrow_back_rounded,
                    //   onTap: () => Navigator.pop(context),
                    // ),
                    IconButton(onPressed: (){Navigator.pop(context);},
                        icon: Icon(Icons.arrow_back_rounded, color: ColorsManager.white,size: 26.sp,)),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child: Text(
                        'Hospital Visit Schedule',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 18.sp,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ),
          
              Padding(
                padding: REdgeInsets.all(13),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.asset(
                        widget.doctor.image,
                        height: 45.h,
                        width: 45.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.doctor.name,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14.sp)),
                        Text(widget.doctor.specialty,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.attach_money_rounded, size: 18.sp,),

                        Text(widget.doctor.price,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12)),
                      ],
                    )

                  ],
                ),
              ),
          
              Padding(
                padding: REdgeInsets.only(left: 8.w, right: 8.w),
                child: Divider(thickness: 0.5.w),
              ),
              Padding(
                padding: REdgeInsets.only(left: 10.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      AvailableDaysWidget(
                        date: formattedDate,  // "Today"
                        slots: '${_getTotalSlots("today")} Slots available',
                        isSelected: selectedDay == "today",
                        onTap: () => setState(() {
                          selectedDay = "today";
                          selectedTime = null;
                        }),
                      ),
                      SizedBox(width: 6.w),
                      AvailableDaysWidget(
                        date: formattedTomorrow,  // "Tomorrow"
                        slots: '${_getTotalSlots("tomorrow")} Slots available',
                        isSelected: selectedDay == "tomorrow",
                        onTap: () => setState(() {
                          selectedDay = "tomorrow";
                          selectedTime = null;
                        }),
                      ),
                      SizedBox(width: 6.w),
                      AvailableDaysWidget(
                        date: formattedDayAfterTomorrow,  // Day after tomorrow
                        slots: '${_getTotalSlots("dayAfterTomorrow")} Slots available',
                        isSelected: selectedDay == "dayAfterTomorrow",
                        onTap: () => setState(() {
                          selectedDay = "dayAfterTomorrow";
                          selectedTime = null;
                        }),
                      ),
                      SizedBox(width: 6.w),
                      AvailableDaysWidget(
                        date: formattedDayAfterAfterTomorrow,
                        slots: '${_getTotalSlots("dayAfterAfterTomorrow")} Slots available',
                        isSelected: selectedDay == "dayAfterAfterTomorrow",
                        onTap: () => setState(() {
                          selectedDay = "dayAfterAfterTomorrow";
                          selectedTime = null;
                        }),
                      ),
                    ],
                  ),
                ),
              ),
          
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "${_getReadableSelectedDay(selectedDay)}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
              ),
          
              SizedBox(height: 6.h),
              ChoiceChipWidget(),
          
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var period in ["Morning", "Evening", "Night"])
                      if (visitSlots[selectedDay] != null && (visitSlots[selectedDay]![period]?.isNotEmpty ?? false)) ...[
                        Text('$period ${visitSlots[selectedDay]![period]!.length} Slots',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize : 14,fontWeight: FontWeight.w500)),
                        Wrap(
                          spacing: 6,
                          children: visitSlots[selectedDay]![period]!.map((time) {
                            return ChoiceChip(
                              backgroundColor: ColorsManager.beige,
                              selectedColor: ColorsManager.fadedBlue3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12,color: Theme.of(context).colorScheme.primaryFixed),
                              label: Text(time),
                              selected: selectedTime == time,
                              onSelected: (val) {
                                setState(() {
                                  selectedTime = time;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16.h),
                      ]
                  ],
          
                ),
              ),
              SizedBox(height: 24.h),
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
                            date: _getReadableSelectedDay(selectedDay),  // اليوم المختار بصيغة مقروءة
                            time: selectedTime!,                         // الوقت اللي اختاره المستخدم
                            price: widget.doctor.price,
                            image: widget.doctor.image,
                          );

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PatientDetailsScreen(doctor: selectedDoctor,selectedDay: selectedDay, selectedTime: '$selectedTime',),
                              ),
                            );
                          },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.blue2,
                          padding: REdgeInsets.symmetric(vertical: 10.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  int _getTotalSlots(String dateKey) {
    final dayData = visitSlots[dateKey];
    if (dayData == null) return 0;

    int total = 0;
    for (var slots in dayData.values) {
      total += slots.length;
    }
    return total;
  }

  String _getFormattedDate(DateTime date) {
    return '${_getDayOfWeek(date.weekday)}, ${date.day} ${_getMonthName(date.month)}';
  }

  String _getDayOfWeek(int weekday) {
    const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return daysOfWeek[weekday - 1];
  }

  String _getReadableSelectedDay(String key) {
    final now = DateTime.now();

    switch (key) {
      case "today":
        return 'Today, ${now.day} ${_getMonthName(now.month)}';
      case "tomorrow":
        final date = now.add(const Duration(days: 1));
        return 'Tomorrow, ${date.day} ${_getMonthName(date.month)}';
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
