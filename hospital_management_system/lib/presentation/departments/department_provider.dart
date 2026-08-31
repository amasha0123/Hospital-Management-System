import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/department.dart';
import '../../data/repositories/department_repository.dart';

final departmentRepositoryProvider = Provider<DepartmentRepository>((ref) => DepartmentRepository());

final departmentListProvider = FutureProvider<List<Department>>((ref) async {
  final repo = ref.watch(departmentRepositoryProvider);
  return repo.getDepartments();
});
