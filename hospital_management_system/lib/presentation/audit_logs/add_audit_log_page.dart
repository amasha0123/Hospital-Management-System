import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/audit_log.dart';
import 'audit_log_provider.dart';

class AddAuditLogPage extends ConsumerStatefulWidget {
  const AddAuditLogPage({super.key});

  @override
  ConsumerState<AddAuditLogPage> createState() => _AddAuditLogPageState();
}

class _AddAuditLogPageState extends ConsumerState<AddAuditLogPage> {
  final _formKey = GlobalKey<FormState>();
  final _actionController = TextEditingController();
  final _actorController = TextEditingController();
  final _entityTypeController = TextEditingController();
  final _entityIdController = TextEditingController();
  final _detailsController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _actionController.dispose();
    _actorController.dispose();
    _entityTypeController.dispose();
    _entityIdController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final repo = ref.read(auditLogRepositoryProvider);

    try {
      final log = AuditLog(
        id: '',
        action: _actionController.text.trim(),
        actor: _actorController.text.trim(),
        entityType: _entityTypeController.text.trim(),
        entityId: _entityIdController.text.trim(),
        details: _detailsController.text.trim(),
        createdAt: DateTime.now(),
      );

      await repo.createAuditLog(log);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Audit log created successfully.')),
        );
        ref.invalidate(auditLogListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create audit log: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Audit Log')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _actionController,
                decoration: const InputDecoration(labelText: 'Action *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter action.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _actorController,
                decoration: const InputDecoration(labelText: 'Actor *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter actor.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _entityTypeController,
                decoration: const InputDecoration(labelText: 'Entity Type *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter entity type.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _entityIdController,
                decoration: const InputDecoration(labelText: 'Entity ID *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter entity ID.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(labelText: 'Details *'),
                minLines: 3,
                maxLines: 5,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter details.' : null,
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
                    : const Text('Save Log'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
