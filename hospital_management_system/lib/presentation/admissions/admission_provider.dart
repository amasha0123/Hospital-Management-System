import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/admission.dart';
import '../../data/repositories/admission_repository.dart';

final admissionRepositoryProvider = Provider<AdmissionRepository>((ref) => AdmissionRepository());

final admissionListProvider = FutureProvider<List<Admission>>((ref) async {
  final repo = ref.watch(admissionRepositoryProvider);
  return repo.getAdmissions();
});
