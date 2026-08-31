import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/lab_test.dart';
import '../../data/repositories/lab_test_repository.dart';

final labTestRepositoryProvider = Provider<LabTestRepository>((ref) => LabTestRepository());

final labTestListProvider = FutureProvider<List<LabTest>>((ref) async {
  final repo = ref.watch(labTestRepositoryProvider);
  return repo.getLabTests();
});
