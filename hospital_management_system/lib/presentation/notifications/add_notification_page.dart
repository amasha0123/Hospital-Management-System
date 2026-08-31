import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/notification_item.dart';
import 'notification_provider.dart';

class AddNotificationPage extends ConsumerStatefulWidget {
  const AddNotificationPage({super.key});

  @override
  ConsumerState<AddNotificationPage> createState() => _AddNotificationPageState();
}

class _AddNotificationPageState extends ConsumerState<AddNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _recipientController = TextEditingController();
  final _typeController = TextEditingController(text: 'General');
  final _messageController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _recipientController.dispose();
    _typeController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final repo = ref.read(notificationRepositoryProvider);

    try {
      final notification = NotificationItem(
        id: '',
        title: _titleController.text.trim(),
        message: _messageController.text.trim(),
        recipient: _recipientController.text.trim(),
        type: _typeController.text.trim(),
        isRead: false,
        createdAt: DateTime.now(),
      );

      await repo.createNotification(notification);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification sent successfully.')),
        );
        ref.invalidate(notificationListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send notification: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Notification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter a title.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _recipientController,
                decoration: const InputDecoration(labelText: 'Recipient *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter recipient.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Type *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter notification type.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(labelText: 'Message *'),
                minLines: 3,
                maxLines: 6,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter a message.' : null,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _saving ? null : _submit,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Send Notification'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
