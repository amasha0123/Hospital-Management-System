import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/patient.dart';
import '../../data/repositories/patient_repository.dart';

final patientRepositoryProvider = Provider<PatientRepository>((ref) => PatientRepository());

final patientListProvider = FutureProvider<List<Patient>>((ref) async {
  final repo = ref.watch(patientRepositoryProvider);
  return repo.getPatients();
});
