import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/notification_item.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _notifications =>
      _firestore.collection('notifications');

  Future<List<NotificationItem>> getNotifications() async {
    final snapshot = await _notifications.orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) => NotificationItem.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<NotificationItem>> watchNotifications() {
    return _notifications.orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => NotificationItem.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createNotification(NotificationItem notification) async {
    final ref = await _notifications.add(notification.toMap());
    return ref.id;
  }

  Future<void> markAsRead(String id) async {
    await _notifications.doc(id).update({'isRead': true});
  }

  Future<void> deleteNotification(String id) async {
    await _notifications.doc(id).delete();
  }

  Future<List<NotificationItem>> searchNotifications(String query) async {
    if (query.trim().isEmpty) return getNotifications();

    final value = query.toLowerCase();
    final snapshot = await _notifications.get();
    return snapshot.docs
        .map((doc) => NotificationItem.fromMap(doc.id, doc.data()))
        .where((notification) {
          final title = notification.title.toLowerCase();
          final message = notification.message.toLowerCase();
          final recipient = notification.recipient.toLowerCase();
          return title.contains(value) ||
              message.contains(value) ||
              recipient.contains(value) ||
              notification.type.toLowerCase().contains(value);
        })
        .toList();
  }
}
