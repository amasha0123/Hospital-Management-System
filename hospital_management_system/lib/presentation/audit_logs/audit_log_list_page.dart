import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'audit_log_provider.dart';

class AuditLogListPage extends ConsumerWidget {
  const AuditLogListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(auditLogListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Audit Logs')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/audit-logs/add'),
        child: const Icon(Icons.add),
      ),
      body: logsAsync.when(
        data: (logs) => logs.isEmpty
            ? const Center(child: Text('No audit logs found.'))
            : ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log = logs[index];
                  return ListTile(
                    title: Text('${log.action} • ${log.entityType}'),
                    subtitle: Text('${log.actor} • ${log.details}'),
                    trailing: Text(log.createdAt.toLocal().toString().split(' ')[0]),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load audit logs.\n$error')),
      ),
    );
  }
}
