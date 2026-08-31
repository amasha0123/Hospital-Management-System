import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'admission_provider.dart';

class AdmissionListPage extends ConsumerWidget {
  const AdmissionListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admissionsAsync = ref.watch(admissionListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Admissions')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/admissions/add'),
        child: const Icon(Icons.add),
      ),
      body: admissionsAsync.when(
        data: (admissions) => admissions.isEmpty
            ? const Center(child: Text('No admissions found.'))
            : ListView.builder(
                itemCount: admissions.length,
                itemBuilder: (context, index) {
                  final admission = admissions[index];
                  return ListTile(
                    title: Text(admission.patientName),
                    subtitle: Text('${admission.doctorName} • ${admission.ward} • ${admission.bedNumber}'),
                    trailing: Chip(label: Text(admission.status)),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load admissions.\n$error')),
      ),
    );
  }
}
