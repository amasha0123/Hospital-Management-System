import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'patient_provider.dart';

class PatientListPage extends ConsumerWidget {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Patients')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: patientsAsync.when(
        data: (patients) => patients.isEmpty
            ? const Center(child: Text('No patients found.'))
            : ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  return ListTile(
                    title: Text('${patient.firstName} ${patient.lastName}'),
                    subtitle: Text('${patient.patientNumber} • ${patient.phone}'),
                    trailing: Chip(
                      label: Text(patient.isActive ? 'Active' : 'Inactive'),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load patients.\n$error')),
      ),
    );
  }
}
