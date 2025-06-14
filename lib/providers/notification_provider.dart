import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  NotificationProvider() {
    loadNotifications();
  }

  void addNotification(String title, String message, Icon icon) {
    _notifications.insert(
      0,
      NotificationModel(
        title: title,
        message: message,
        icon: icon,
        timestamp: DateTime.now(),
      ),
    );
    saveNotifications();
    notifyListeners();
  }

  void markAsRead(int index) {
    _notifications[index].isRead = true;
    saveNotifications();
    notifyListeners();
  }

  void removeNotification(int index) {
    _notifications.removeAt(index);
    saveNotifications();
    notifyListeners();
  }

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _notifications.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('notifications', data);
  }

  Future<void> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('notifications');
    if (data != null) {
      _notifications.clear();
      _notifications.addAll(
        data.map((e) => NotificationModel.fromJson(jsonDecode(e))),
      );
      notifyListeners();
    }
  }
}
