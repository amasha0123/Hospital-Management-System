import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'doctor_provider.dart';

class DoctorListPage extends ConsumerWidget {
  const DoctorListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorsAsync = ref.watch(doctorListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Doctors')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/doctors/add'),
        child: const Icon(Icons.add),
      ),
      body: doctorsAsync.when(
        data: (doctors) => doctors.isEmpty
            ? const Center(child: Text('No doctors found.'))
            : ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return ListTile(
                    title: Text(doctor.fullName),
                    subtitle: Text('${doctor.specialty} • ${doctor.department}'),
                    trailing: Chip(
                      label: Text(doctor.isAvailable ? 'Available' : 'Busy'),
                    ),
                    onTap: () => context.push('/doctors/edit'),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load doctors.\n$error')),
      ),
    );
  }
}
