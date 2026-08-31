import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'staff_provider.dart';

class StaffListPage extends ConsumerWidget {
  const StaffListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(staffListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Staff')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/staff/add'),
        child: const Icon(Icons.add),
      ),
      body: staffAsync.when(
        data: (staff) => staff.isEmpty
            ? const Center(child: Text('No staff members found.'))
            : ListView.builder(
                itemCount: staff.length,
                itemBuilder: (context, index) {
                  final member = staff[index];
                  return ListTile(
                    title: Text(member.fullName),
                    subtitle: Text('${member.role} • ${member.department}'),
                    trailing: Chip(
                      label: Text(member.isActive ? 'Active' : 'Inactive'),
                      backgroundColor: member.isActive ? Colors.green.shade100 : Colors.red.shade100,
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load staff members.\n$error')),
      ),
    );
  }
}
