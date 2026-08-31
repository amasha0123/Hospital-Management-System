import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/appointment.dart';
import '../../data/repositories/appointment_repository.dart';

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) => AppointmentRepository());

final appointmentListProvider = FutureProvider<List<Appointment>>((ref) async {
  final repo = ref.watch(appointmentRepositoryProvider);
  return repo.getAppointments();
});
