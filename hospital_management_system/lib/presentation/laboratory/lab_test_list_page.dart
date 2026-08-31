import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'lab_test_provider.dart';

class LabTestListPage extends ConsumerWidget {
  const LabTestListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labTestsAsync = ref.watch(labTestListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Laboratory')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/laboratory/add'),
        child: const Icon(Icons.add),
      ),
      body: labTestsAsync.when(
        data: (labTests) => labTests.isEmpty
            ? const Center(child: Text('No laboratory tests found.'))
            : ListView.builder(
                itemCount: labTests.length,
                itemBuilder: (context, index) {
                  final labTest = labTests[index];
                  return ListTile(
                    title: Text(labTest.testName),
                    subtitle: Text('${labTest.patientName} • ${labTest.doctorName}'),
                    trailing: Chip(
                      label: Text(labTest.status),
                      backgroundColor: labTest.isCompleted ? Colors.green.shade100 : Colors.orange.shade100,
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load laboratory tests.\n$error')),
      ),
    );
  }
}
