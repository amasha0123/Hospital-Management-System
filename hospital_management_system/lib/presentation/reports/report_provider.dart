import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/report.dart';
import '../../data/repositories/report_repository.dart';

final reportRepositoryProvider = Provider<ReportRepository>((ref) => ReportRepository());

final reportListProvider = FutureProvider<List<Report>>((ref) async {
  final repo = ref.watch(reportRepositoryProvider);
  return repo.getReports();
});
