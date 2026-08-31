import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/notification_item.dart';
import '../../data/repositories/notification_repository.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) => NotificationRepository());

final notificationListProvider = FutureProvider<List<NotificationItem>>((ref) async {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.getNotifications();
});
