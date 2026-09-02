import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'attendance_provider.dart';

class AttendanceListPage extends ConsumerWidget {
  const AttendanceListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(attendanceListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance & Leave'),
        actions: [
          IconButton(
            onPressed: () => context.push('/staff'),
            icon: const Icon(Icons.badge_outlined),
          ),
        ],
      ),
      body: attendanceAsync.when(
        data: (records) => records.isEmpty
            ? const Center(child: Text('No attendance records found.'))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(record.employeeName),
                      subtitle: Text('${record.role} • ${record.department} • ${record.checkIn} - ${record.checkOut}'),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(record.status),
                          Text('${record.hoursWorked.toStringAsFixed(1)} hrs'),
                        ],
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Unable to load attendance records.\n$error'),
        ),
      ),
    );
  }
}
