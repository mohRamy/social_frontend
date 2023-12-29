import 'dart:convert';

import '../../../../../core/enums/notification_enum.dart';

class NotificationModel {
  String? id;
  String userId;
  String typeId;
  Notification notification;
  List<String> interactive;
  final DateTime createdAt;
  bool isSeen;
  NotificationEnum notificationType;

  NotificationModel({
    this.id,
    required this.userId,
    required this.typeId,
    required this.notification,
    required this.interactive,
    required this.createdAt,
    required this.isSeen,
    required this.notificationType,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      typeId: map['typeId'] ?? '',
      notification: Notification.fromMap(map['notification']),
      interactive: List<String>.from(map['interactive'] ?? []),
      createdAt: DateTime.parse(map['createdAt'] ?? "2023-11-13T10:16:59.049+00:00"),
      isSeen: map['isSeen'] ?? false,
      notificationType: map['notificationType'].toString().toEnum(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'typeId': typeId,
      'notification': notification,
      'interactive': interactive,
      'tokenFCM': createdAt,
      'isSeen': isSeen,
      'notificationType': notificationType,
    };
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}

class Notification {
  String title;
  String body;

  Notification({
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source));
}
