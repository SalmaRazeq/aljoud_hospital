import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/notification_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          loc.notification,
          style: TextStyle(
            fontSize: 26.sp,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: notificationProvider.notifications.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[500],
          thickness: 1.5,
          height: 0.h,
        ),
        itemBuilder: (context, index) {
          final notification = notificationProvider.notifications[index];
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
              notificationProvider.removeNotification(index);
            },
            child: GestureDetector(
              onTap: () {
                notificationProvider.markAsRead(index);
              },
              child: Card(
                color: notification.isRead
                    ? Colors.transparent
                    : Colors.grey.withOpacity(0.3),
                margin: REdgeInsets.only(
                  left: 3,
                  right: 3,
                ),
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
      return loc.yesterday; // لازم تكون معرفها في ملف الترجمة
    } else {
      return '${time.day.toString().padLeft(2, '0')}/'
          '${time.month.toString().padLeft(2, '0')}/'
          '${time.year}';
    }
  }
}
