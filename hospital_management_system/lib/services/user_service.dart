import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  Future<UserModel?> getUserByUid(String uid) async {
    final snapshot = await _users.doc(uid).get();
    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }
    return UserModel.fromFirestore(uid, snapshot.data());
  }

  Future<List<UserModel>> getUsers() async {
    final snapshot = await _users.orderBy('name').get();
    return snapshot.docs
        .map((doc) => UserModel.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
    required String role,
    bool isActive = true,
  }) async {
    final safeRole = UserModel.normalizeRole(role);
    if (safeRole == 'INVALID_ROLE') {
      throw FormatException('Unsupported role: $role');
    }

    await _users.doc(uid).set({
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'role': safeRole,
      'isActive': isActive,
    });
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    await _users.doc(uid).update(data);
  }

  Future<void> setUserStatus(String uid, bool isActive) async {
    await _users.doc(uid).update({'isActive': isActive});
  }

  Future<void> deleteUserProfile(String uid) async {
    await _users.doc(uid).delete();
  }
}
