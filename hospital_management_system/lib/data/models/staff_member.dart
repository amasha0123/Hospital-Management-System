class StaffMember {
  final String id;
  final String employeeNumber;
  final String firstName;
  final String lastName;
  final String role;
  final String department;
  final String phone;
  final String email;
  final bool isActive;

  const StaffMember({
    required this.id,
    required this.employeeNumber,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.department,
    required this.phone,
    required this.email,
    this.isActive = true,
  });

  String get fullName => '$firstName $lastName';

  factory StaffMember.fromMap(String id, Map<String, dynamic> map) {
    return StaffMember(
      id: id,
      employeeNumber: map['employeeNumber'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      role: map['role'] ?? '',
      department: map['department'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeNumber': employeeNumber,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'department': department,
      'phone': phone,
      'email': email,
      'isActive': isActive,
    };
  }
}
