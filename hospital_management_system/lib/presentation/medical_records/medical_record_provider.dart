import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/medical_record.dart';
import '../../data/repositories/medical_record_repository.dart';

final medicalRecordRepositoryProvider = Provider<MedicalRecordRepository>((ref) => MedicalRecordRepository());

final medicalRecordListProvider = FutureProvider<List<MedicalRecord>>((ref) async {
  final repo = ref.watch(medicalRecordRepositoryProvider);
  return repo.getRecords();
});
