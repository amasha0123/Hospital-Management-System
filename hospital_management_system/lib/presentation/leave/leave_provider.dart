import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/leave_request.dart';
import '../../data/repositories/leave_repository.dart';

final leaveRepositoryProvider = Provider<LeaveRepository>((ref) => LeaveRepository());

final leaveListProvider = FutureProvider<List<LeaveRequest>>((ref) async {
  final repo = ref.watch(leaveRepositoryProvider);
  return repo.getLeaveRequests();
});
