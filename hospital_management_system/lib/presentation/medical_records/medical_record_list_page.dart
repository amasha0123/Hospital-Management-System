import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'medical_record_provider.dart';

class MedicalRecordListPage extends ConsumerWidget {
  const MedicalRecordListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(medicalRecordListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Medical Records')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/medical-records/add'),
        child: const Icon(Icons.add),
      ),
      body: recordsAsync.when(
        data: (records) => records.isEmpty
            ? const Center(child: Text('No medical records found.'))
            : ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return ListTile(
                    title: Text(record.patientName),
                    subtitle: Text('${record.diagnosis} • ${record.doctorName}'),
                    trailing: Text(record.recordNumber),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load records.\n$error')),
      ),
    );
  }
}
