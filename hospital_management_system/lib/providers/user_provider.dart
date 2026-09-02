import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'auth_provider.dart';

final userServiceProvider = Provider<UserService>((ref) => UserService());

final currentUserProfileProvider = FutureProvider<UserModel?>((ref) async {
  final authUser = ref.watch(currentUserProvider);
  if (authUser == null) return null;

  final service = ref.watch(userServiceProvider);
  return service.getUserByUid(authUser.uid);
});

final userRoleProvider = Provider<String>((ref) {
  final user = ref.watch(currentUserProfileProvider).asData?.value;
  return user?.role ?? 'UNAUTHENTICATED';
});

final userListProvider = FutureProvider<List<UserModel>>((ref) async {
  final service = ref.watch(userServiceProvider);
  return service.getUsers();
});
