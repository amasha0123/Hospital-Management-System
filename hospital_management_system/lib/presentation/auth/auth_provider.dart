import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  final service = ref.watch(authServiceProvider);
  return service.authStateChanges();
});

final userProfileProvider = StreamProvider<Map<String, dynamic>?>((ref) {
  final service = ref.watch(authServiceProvider);
  final user = ref.watch(authStateProvider).asData?.value;

  if (user == null) {
    return const Stream.empty();
  }

  return service.watchUserProfile(user.uid);
});

final userRoleProvider = Provider<String>((ref) {
  final profile = ref.watch(userProfileProvider).asData?.value;
  final role = profile?['role'] as String? ?? 'ADMIN';
  return role.toUpperCase();
});
