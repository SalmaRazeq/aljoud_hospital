import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/notification_provider.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // حالة القراءة (الأيقونة الحمراء) للإشعارات الثابتة
  List<bool> fixedReadStatus = [false, false];

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          loc.notification,
          style: TextStyle(fontSize: 26.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: notificationProvider.notifications.length + 2,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[500],
          thickness: 1.5,
          height: 0.h,
        ),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildFixedNotification(
              index: 0,
              isRead: fixedReadStatus[0],
              icon: const Icon(Icons.access_time, color: Colors.orange),
              title: 'Reminder!',
              message:
                  'Doctor Appointment Today At 6:30pm, Need To Pick Up Files On The Way.',
              action2: 'Mark As Done',
              time: '6:00 PM',
            );
          }
          if (index == 1) {
            return _buildFixedNotification(
              index: 1,
              isRead: fixedReadStatus[1],
              icon: const Icon(Icons.monitor_weight_outlined,
                  color: Colors.lightBlueAccent),
              title: "It’s Time To Enter Your Weight",
              message:
                  "Track Your Weight And Help Us Customize Your Weekly Health Tip For You",
              action1: "Add Weight Entry",
              onAction1Pressed: () {
                Navigator.pushNamed(context, RoutesManager.editProfile);
              },
              time: "9:20 AM",
            );
          }

          final notification = notificationProvider.notifications[index - 2];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              padding: REdgeInsets.symmetric(horizontal: 20.w),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              notificationProvider.removeNotification(index - 2);
            },
            child: GestureDetector(
              onTap: () {
                notificationProvider.markAsRead(index - 2);
              },
              child: Card(
                color: notification.isRead
                    ? Colors.transparent
                    : Colors.grey.withOpacity(0.3),
                margin: REdgeInsets.symmetric(horizontal: 0),
                elevation: 0,
                child: Padding(
                  padding: REdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      notification.icon,
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notification.title,
                                style: Theme.of(context).textTheme.bodySmall),
                            SizedBox(height: 6.h),
                            Text(notification.message,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 12.sp, color: Colors.grey)),
                            SizedBox(height: 6.h),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                _formatTime(context, notification.timestamp),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!notification.isRead)
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Icon(Icons.circle,
                              color: Colors.red, size: 10.sp),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFixedNotification({
    required int index,
    required bool isRead,
    required Icon icon,
    required String title,
    required String message,
    String? action1,
    String? action2,
    VoidCallback? onAction1Pressed,
    required String time,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fixedReadStatus[index] = true; // علامة قرأ تم تفعيلها
        });
      },
      child: Card(
        margin: REdgeInsets.symmetric(
          horizontal: 0,
        ),
        elevation: 0,
        color: isRead ? Colors.transparent : Colors.grey.withOpacity(0.3),
        child: Padding(
          padding: REdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(title,
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                        if (!isRead)
                          Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: Icon(Icons.circle,
                                color: Colors.red, size: 10.sp),
                          ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(message,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 12.sp, color: Colors.grey)),
                    SizedBox(height: 6.h),
                    SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          if (action1 != null)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  fixedReadStatus[index] = true;
                                });
                                if (onAction1Pressed != null) {
                                  onAction1Pressed();
                                }
                              },
                              child: Text(
                                action1,
                                style: GoogleFonts.inter(
                                  fontSize: 11.sp,
                                  color: ColorsManager.blue4,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          if (action2 != null)
                            isRead
                                ? const Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                    size: 26,
                                  )
                                : TextButton(
                                    onPressed: () {
                                      setState(() {
                                        fixedReadStatus[index] = true;
                                      });
                                    },
                                    child: Text(
                                      action2,
                                      style: GoogleFonts.inter(
                                        fontSize: 11.sp,
                                        color: ColorsManager.blue4,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                          const Spacer(),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(BuildContext context, DateTime time) {
    final loc = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final notificationDate = DateTime(time.year, time.month, time.day);

    if (notificationDate == today) {
      final hour = time.hour.toString().padLeft(2, '0');
      final minute = time.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else if (notificationDate == yesterday) {
      return loc.yesterday;
    } else {
      return '${time.day.toString().padLeft(2, '0')}/'
          '${time.month.toString().padLeft(2, '0')}/'
          '${time.year}';
    }
  }
}
