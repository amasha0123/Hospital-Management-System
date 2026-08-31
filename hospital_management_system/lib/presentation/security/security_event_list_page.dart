import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'security_provider.dart';

class SecurityEventListPage extends ConsumerWidget {
  const SecurityEventListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(securityEventListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Security')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/security/add'),
        child: const Icon(Icons.add),
      ),
      body: eventsAsync.when(
        data: (events) => events.isEmpty
            ? const Center(child: Text('No security events found.'))
            : ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return ListTile(
                    leading: Icon(
                      event.severity == 'High' ? Icons.warning_amber_rounded : Icons.shield_outlined,
                      color: event.severity == 'High' ? Colors.red : Colors.blue,
                    ),
                    title: Text('${event.eventType} • ${event.actor}'),
                    subtitle: Text('${event.location} • ${event.description}'),
                    trailing: Text(event.createdAt.toLocal().toString().split(' ')[0]),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load security events.\n$error')),
      ),
    );
  }
}
