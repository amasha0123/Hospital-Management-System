import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'leave_provider.dart';

class LeaveListPage extends ConsumerWidget {
  const LeaveListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaveAsync = ref.watch(leaveListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Leave Requests')),
      body: leaveAsync.when(
        data: (requests) => requests.isEmpty
            ? const Center(child: Text('No leave requests found.'))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(request.employeeName),
                      subtitle: Text('${request.leaveType} • ${request.department} • ${request.reason}'),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(request.status),
                          Text('${request.startDate.day}/${request.startDate.month} - ${request.endDate.day}/${request.endDate.month}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load leave requests.\n$error')),
      ),
    );
  }
}
