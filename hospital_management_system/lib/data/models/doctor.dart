class Doctor {
  final String id;
  final String doctorNumber;
  final String firstName;
  final String lastName;
  final String specialty;
  final String department;
  final String phone;
  final String email;
  final bool isAvailable;
  final bool isActive;

  const Doctor({
    required this.id,
    required this.doctorNumber,
    required this.firstName,
    required this.lastName,
    required this.specialty,
    required this.department,
    required this.phone,
    required this.email,
    this.isAvailable = true,
    this.isActive = true,
  });

  String get fullName => '$firstName $lastName';

  factory Doctor.fromMap(String id, Map<String, dynamic> map) {
    return Doctor(
      id: id,
      doctorNumber: map['doctorNumber'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      specialty: map['specialty'] ?? '',
      department: map['department'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      isAvailable: map['isAvailable'] ?? true,
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorNumber': doctorNumber,
      'firstName': firstName,
      'lastName': lastName,
      'specialty': specialty,
      'department': department,
      'phone': phone,
      'email': email,
      'isAvailable': isAvailable,
      'isActive': isActive,
    };
  }
}
