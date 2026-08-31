import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/security_event.dart';
import '../../data/repositories/security_repository.dart';

final securityRepositoryProvider = Provider<SecurityRepository>((ref) => SecurityRepository());

final securityEventListProvider = FutureProvider<List<SecurityEvent>>((ref) async {
  final repo = ref.watch(securityRepositoryProvider);
  return repo.getSecurityEvents();
});
