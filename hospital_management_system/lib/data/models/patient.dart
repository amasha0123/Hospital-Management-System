class Patient {
  final String id;
  final String patientNumber;
  final String firstName;
  final String lastName;
  final String gender;
  final String phone;
  final String email;
  final bool isActive;

  const Patient({
    required this.id,
    required this.patientNumber,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.phone,
    required this.email,
    this.isActive = true,
  });

  String get fullName => '$firstName $lastName';

  factory Patient.fromMap(String id, Map<String, dynamic> map) {
    return Patient(
      id: id,
      patientNumber: map['patientNumber'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      gender: map['gender'] ?? 'Unknown',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientNumber': patientNumber,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'phone': phone,
      'email': email,
      'isActive': isActive,
    };
  }
}
 