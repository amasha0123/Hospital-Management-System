import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signIn(String email, String password) async {
    return _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<UserModel> getAuthenticatedUserProfile(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();
    if (!snapshot.exists || snapshot.data() == null) {
      throw StateError('User profile not found. Please contact the administrator.');
    }

    final user = UserModel.fromFirestore(uid, snapshot.data());
    if (!user.isActive) {
      throw StateError('This account is inactive. Please contact the administrator.');
    }

    return user;
  }

  Future<void> createUserAccount({
    required String name,
    required String email,
    required String password,
    required String role,
    bool isActive = true,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final uid = credential.user!.uid;
    final normalizedRole = UserModel.normalizeRole(role);

    if (normalizedRole == 'INVALID_ROLE') {
      await credential.user!.delete();
      throw FormatException('Unsupported role: $role');
    }

    await _firestore.collection('users').doc(uid).set({
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'role': normalizedRole,
      'isActive': isActive,
    });
  }

  Future<void> updateUserStatus(String uid, bool isActive) async {
    await _firestore.collection('users').doc(uid).update({'isActive': isActive});
  }

  Future<void> updateUserRole(String uid, String role) async {
    final normalizedRole = UserModel.normalizeRole(role);
    if (normalizedRole == 'INVALID_ROLE') {
      throw FormatException('Unsupported role: $role');
    }

    await _firestore.collection('users').doc(uid).update({'role': normalizedRole});
  }
}
