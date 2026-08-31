import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'notification_provider.dart';

class NotificationListPage extends ConsumerWidget {
  const NotificationListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/notifications/add'),
        child: const Icon(Icons.add),
      ),
      body: notificationsAsync.when(
        data: (notifications) => notifications.isEmpty
            ? const Center(child: Text('No notifications found.'))
            : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return ListTile(
                    leading: Icon(
                      notification.isRead ? Icons.mark_email_read : Icons.notifications_active,
                      color: notification.isRead ? Colors.green : Colors.orange,
                    ),
                    title: Text(notification.title),
                    subtitle: Text('${notification.recipient} • ${notification.type}'),
                    trailing: Text(notification.createdAt.toLocal().toString().split(' ')[0]),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load notifications.\n$error')),
      ),
    );
  }
}
