import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/staff_member.dart';
import '../../data/repositories/staff_repository.dart';

final staffRepositoryProvider = Provider<StaffRepository>((ref) => StaffRepository());

final staffListProvider = FutureProvider<List<StaffMember>>((ref) async {
  final repo = ref.watch(staffRepositoryProvider);
  return repo.getStaffMembers();
});
