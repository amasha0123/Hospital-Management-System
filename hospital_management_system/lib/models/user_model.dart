class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final bool isActive;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.isActive,
  });

  static const List<String> validRoles = [
    'ADMIN',
    'DOCTOR',
    'NURSE',
    'RECEPTIONIST',
    'LAB_STAFF',
    'PHARMACIST',
    'ACCOUNTANT',
  ];

  static String normalizeRole(dynamic value) {
    final role = (value ?? '').toString().trim().toUpperCase();
    return validRoles.contains(role) ? role : 'INVALID_ROLE';
  }

  factory UserModel.fromFirestore(String uid, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('User profile does not exist for uid: $uid');
    }

    final role = normalizeRole(data['role']);
    if (role == 'INVALID_ROLE') {
      throw FormatException('User role is invalid for uid: $uid');
    }

    return UserModel(
      uid: uid,
      name: (data['name'] ?? '').toString().trim(),
      email: (data['email'] ?? '').toString().trim(),
      role: role,
      isActive: data['isActive'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'isActive': isActive,
    };
  }
}
