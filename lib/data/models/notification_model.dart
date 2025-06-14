import 'package:flutter/widgets.dart';

class NotificationModel {
  final Icon icon;
  final String title;
  final String message;
  final DateTime timestamp;
  bool isRead;

  NotificationModel({
    required this.icon,
    required this.title,
    required this.message,
    this.isRead = false,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'title': title,
        'message': message,
        'isRead': isRead,
        'timestamp': timestamp.toIso8601String(),
        'iconCode': icon.icon!.codePoint,
        'iconFontFamily': icon.icon!.fontFamily,
      };

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      message: json['message'],
      isRead: json['isRead'] ?? false,
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      icon: Icon(
        IconData(
          json['iconCode'],
          fontFamily: json['iconFontFamily'],
        ),
      ),
    );
  }
}
