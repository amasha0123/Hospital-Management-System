import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/doctor.dart';
import '../../data/repositories/doctor_repository.dart';

final doctorRepositoryProvider = Provider<DoctorRepository>((ref) => DoctorRepository());

final doctorListProvider = FutureProvider<List<Doctor>>((ref) async {
  final repo = ref.watch(doctorRepositoryProvider);
  return repo.getDoctors();
});
