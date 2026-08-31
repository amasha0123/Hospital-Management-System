import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String recipient;
  final String type;
  final bool isRead;
  final DateTime createdAt;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.recipient,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationItem.fromMap(String id, Map<String, dynamic> map) {
    return NotificationItem(
      id: id,
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      recipient: map['recipient'] ?? '',
      type: map['type'] ?? 'General',
      isRead: map['isRead'] ?? false,
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'recipient': recipient,
      'type': type,
      'isRead': isRead,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
