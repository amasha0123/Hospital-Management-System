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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/appointments/add'),
        icon: const Icon(Icons.add),
        label: const Text('Schedule'),
      ),
      body: appointmentsAsync.when(
        data: (appointments) {
          final dates = List.generate(7, (index) {
            final date = DateTime.now().add(Duration(days: index));
            return date;
          });

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Calendar View', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF102A43))),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 72,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: dates.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final date = dates[index];
                              final isToday = date.day == DateTime.now().day;
                              return Container(
                                width: 52,
                                decoration: BoxDecoration(
                                  color: isToday ? const Color(0xFF2563EB) : const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(date.day.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: isToday ? Colors.white : const Color(0xFF102A43))),
                                    Text('${_monthShort(date.month)}', style: TextStyle(fontSize: 10, color: isToday ? Colors.white70 : Colors.black54)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: appointments.isEmpty
                        ? const Center(child: Text('No appointments found.'))
                        : ListView.builder(
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              final appointment = appointments[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  title: Text(appointment.patientName),
                                  subtitle: Text('${appointment.doctorName} • ${appointment.appointmentDate.toLocal().toString().split(' ')[0]}'),
                                  trailing: Chip(label: Text(appointment.status)),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load appointments.\n$error')),
      ),
    );
  }

  String _monthShort(int month) {
    const names = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return names[month - 1];
  }
}
