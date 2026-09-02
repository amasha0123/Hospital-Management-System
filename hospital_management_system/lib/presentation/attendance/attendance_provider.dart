import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/attendance_record.dart';
import '../../data/repositories/attendance_repository.dart';

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) => AttendanceRepository());

final attendanceListProvider = FutureProvider<List<AttendanceRecord>>((ref) async {
  final repo = ref.watch(attendanceRepositoryProvider);
  return repo.getAttendanceRecords();
});
