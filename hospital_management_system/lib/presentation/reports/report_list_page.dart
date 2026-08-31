import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'report_provider.dart';

class ReportListPage extends ConsumerWidget {
  const ReportListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(reportListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/reports/add'),
        child: const Icon(Icons.add),
      ),
      body: reportsAsync.when(
        data: (reports) => reports.isEmpty
            ? const Center(child: Text('No reports found.'))
            : ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return ListTile(
                    title: Text(report.title),
                    subtitle: Text('${report.category} • ${report.generatedBy}'),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(report.status),
                        const SizedBox(height: 4),
                        Text(report.generatedAt.toLocal().toString().split(' ')[0]),
                      ],
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load reports.\n$error')),
      ),
    );
  }
}
