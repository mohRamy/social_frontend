import 'dart:convert';

class NotificationModel {
  String? id;
  String userId;
  Notification notification;
  final DateTime createdAt;
  bool isSeen;

  NotificationModel({
    this.id,
    required this.userId,
    required this.notification,
    required this.createdAt,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'notification': notification,
      'tokenFCM': createdAt,
      'isSeen': isSeen,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      notification: Notification.fromMap(map['notification']) ,
      createdAt: DateTime.parse(map["createdAt"]),
      isSeen: map['isSeen'] ?? false,
    );
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
