import 'package:flutter_test/flutter_test.dart';
import 'package:hospital_management_system/data/models/doctor.dart';

void main() {
  test('Doctor model supports identity and display formatting', () {
    final doctor = Doctor.fromMap('doc-1', {
      'doctorNumber': 'D-001',
      'firstName': 'Alice',
      'lastName': 'Nurse',
      'specialty': 'Surgery',
      'department': 'General',
      'phone': '555-0101',
      'email': 'alice@hospital.com',
      'isAvailable': true,
      'isActive': true,
    });

    expect(doctor.id, 'doc-1');
    expect(doctor.fullName, 'Alice Nurse');
    expect(doctor.department, 'General');
    expect(doctor.isAvailable, isTrue);
  });
}
