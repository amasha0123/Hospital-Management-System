import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'billing_provider.dart';

class BillingListPage extends ConsumerWidget {
  const BillingListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billingAsync = ref.watch(billingListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Billing')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/billing/add'),
        child: const Icon(Icons.add),
      ),
      body: billingAsync.when(
        data: (records) => records.isEmpty
            ? const Center(child: Text('No billing records found.'))
            : ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return ListTile(
                    title: Text(record.patientName),
                    subtitle: Text('${record.serviceName} • ${record.doctorName}'),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Rs.${record.amount.toStringAsFixed(2)}'),
                        const SizedBox(height: 4),
                        Chip(label: Text(record.status)),
                      ],
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load billing records.\n$error')),
      ),
    );
  }
}
