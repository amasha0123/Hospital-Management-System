import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'appointment_provider.dart';

class AppointmentListPage extends ConsumerWidget {
  const AppointmentListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync = ref.watch(appointmentListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/appointments/add'),
        child: const Icon(Icons.add),
      ),
      body: appointmentsAsync.when(
        data: (appointments) => appointments.isEmpty
            ? const Center(child: Text('No appointments found.'))
            : ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return ListTile(
                    title: Text(appointment.patientName),
                    subtitle: Text('${appointment.doctorName} • ${appointment.appointmentDate.toLocal().toString().split(' ')[0]}'),
                    trailing: Chip(label: Text(appointment.status)),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load appointments.\n$error')),
      ),
    );
  }
}
