import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/security_event.dart';
import 'security_provider.dart';

class AddSecurityEventPage extends ConsumerStatefulWidget {
  const AddSecurityEventPage({super.key});

  @override
  ConsumerState<AddSecurityEventPage> createState() => _AddSecurityEventPageState();
}

class _AddSecurityEventPageState extends ConsumerState<AddSecurityEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _eventTypeController = TextEditingController();
  final _actorController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _severityController = TextEditingController(text: 'Medium');
  bool _saving = false;

  @override
  void dispose() {
    _eventTypeController.dispose();
    _actorController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _severityController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final repo = ref.read(securityRepositoryProvider);

    try {
      final event = SecurityEvent(
        id: '',
        eventType: _eventTypeController.text.trim(),
        actor: _actorController.text.trim(),
        location: _locationController.text.trim(),
        description: _descriptionController.text.trim(),
        severity: _severityController.text.trim(),
        createdAt: DateTime.now(),
      );

      await repo.createSecurityEvent(event);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Security event recorded successfully.')),
        );
        ref.invalidate(securityEventListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to record event: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Security Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _eventTypeController,
                decoration: const InputDecoration(labelText: 'Event Type *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter event type.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _actorController,
                decoration: const InputDecoration(labelText: 'Actor *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter actor.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter location.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _severityController,
                decoration: const InputDecoration(labelText: 'Severity *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter severity.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description *'),
                minLines: 3,
                maxLines: 5,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter description.' : null,
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
                    : const Text('Record Event'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
