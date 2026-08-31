import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'pharmacy_provider.dart';

class PharmacyListPage extends ConsumerWidget {
  const PharmacyListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pharmacyAsync = ref.watch(pharmacyListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pharmacy')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/pharmacy/add'),
        child: const Icon(Icons.add),
      ),
      body: pharmacyAsync.when(
        data: (items) => items.isEmpty
            ? const Center(child: Text('No pharmacy items found.'))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('${item.category} • Qty: ${item.quantity} • ${item.supplier}'),
                    trailing: Chip(
                      label: Text(item.status),
                      backgroundColor: item.isLowStock ? Colors.orange.shade100 : Colors.green.shade100,
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load pharmacy items.\n$error')),
      ),
    );
  }
}
