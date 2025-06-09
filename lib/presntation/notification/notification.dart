import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(Icons.arrow_back, size: 24.sp),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Notifications',
                        style: GoogleFonts.sourceSerif4(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.settings_outlined, size: 24.sp),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView(
                  children: [
                    notificationTile(
                      icon: Icons.access_time_rounded,
                      iconColor: Colors.teal,
                      dotColor: Colors.red,
                      title: "Reminder!",
                      description:
                          "Doctor Appointment Today At 6:30pm, Need To Pick Up Files On The Way.",
                      actions: ["Mark As Done", "Update"],
                      time: "6:00 PM",
                    ),
                    notificationTile(
                      icon: Icons.access_time_rounded,
                      iconColor: Colors.teal,
                      dotColor: Colors.red,
                      title: "It’s Time To Enter Your Weight",
                      description:
                          "Track Your Weight And Help Us Customize Your Weekly Health Tip For You",
                      actions: ["Add Weight Entry"],
                      time: "9:20 AM",
                    ),
                    notificationTile(
                      icon: Icons.credit_card,
                      iconColor: Colors.pink.shade100,
                      dotColor: null,
                      title: "Payment",
                      description:
                          "Your Payment Has Been Successfully Processed. Thank You!",
                      actions: [],
                      time: "Yesterday",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget notificationTile({
    required IconData icon,
    required Color iconColor,
    Color? dotColor,
    required String title,
    required String description,
    required List<String> actions,
    required String time,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: REdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (dotColor != null)
                Container(
                  width: 10.w,
                  height: 10.w,
                  margin: EdgeInsets.only(right: 6.w),
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.1),
                child: Icon(icon, color: iconColor, size: 18.sp),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                time,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: REdgeInsets.only(left: dotColor != null ? 32.w : 0),
            child: Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.black87,
              ),
            ),
          ),
          if (actions.isNotEmpty)
            Padding(
              padding: REdgeInsets.only(top: 8.h, left: 32.w),
              child: Row(
                children: actions
                    .map(
                      (action) => Padding(
                        padding: REdgeInsets.only(right: 8.w),
                        child: Text(
                          action,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
