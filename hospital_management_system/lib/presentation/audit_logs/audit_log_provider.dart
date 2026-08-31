import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/audit_log.dart';
import '../../data/repositories/audit_log_repository.dart';

final auditLogRepositoryProvider = Provider<AuditLogRepository>((ref) => AuditLogRepository());

final auditLogListProvider = FutureProvider<List<AuditLog>>((ref) async {
  final repo = ref.watch(auditLogRepositoryProvider);
  return repo.getAuditLogs();
});
