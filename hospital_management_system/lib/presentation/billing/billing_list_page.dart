import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'billing_provider.dart';
import 'receipt_service.dart';

class BillingListPage extends ConsumerWidget {
  const BillingListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billingAsync = ref.watch(billingListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Billing')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/billing/add'),
        icon: const Icon(Icons.add),
        label: const Text('Generate Bill'),
      ),
      body: billingAsync.when(
        data: (records) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(Icons.receipt_long, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Revenue Summary', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        Text('Rs.${records.fold<double>(0, (sum, record) => sum + record.amount).toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (records.isEmpty)
              const Center(child: Text('No billing records found.'))
            else
              ...records.map((record) => Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(record.patientName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text('${record.serviceName} • ${record.doctorName}', style: const TextStyle(color: Colors.black54)),
                                  ],
                                ),
                              ),
                              Chip(
                                label: Text(record.status),
                                backgroundColor: record.status == 'Paid'
                                    ? Colors.green.shade100
                                    : Colors.orange.shade100,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(child: Text('Invoice: ${record.invoiceNumber}', style: const TextStyle(fontSize: 12, color: Colors.black54))),
                              Text('Rs.${record.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => _receivePayment(context, ref, record),
                                  icon: const Icon(Icons.payment_rounded),
                                  label: const Text('Receive Payment'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () => _printReceipt(record),
                                  icon: const Icon(Icons.print_rounded),
                                  label: const Text('Print Receipt'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load billing records.\n$error')),
      ),
    );
  }

  Future<void> _receivePayment(BuildContext context, WidgetRef ref, dynamic record) async {
    try {
      await ref.read(billingRepositoryProvider).markAsPaid(record.id);
      ref.invalidate(billingListProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment received successfully.')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unable to receive payment: $e')));
      }
    }
  }

  Future<void> _printReceipt(dynamic record) async {
    await ReceiptService.printInvoice(
      invoiceNumber: record.invoiceNumber,
      patientName: record.patientName,
      doctorName: record.doctorName,
      serviceName: record.serviceName,
      amount: record.amount,
      createdAt: record.createdAt,
      status: record.status,
    );
  }
}
