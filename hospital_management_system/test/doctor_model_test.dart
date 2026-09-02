import 'package:flutter_test/flutter_test.dart';
import 'package:hospital_management_system/data/models/doctor.dart';

void main() {
  test('Doctor data round-trip preserves fields', () {
    const doctor = Doctor(
      id: 'doc-1',
      doctorNumber: 'D-001',
      firstName: 'John',
      lastName: 'Doe',
      specialty: 'Cardiology',
      department: 'Emergency',
      phone: '5551234',
      email: 'john@hospital.com',
      isAvailable: true,
      isActive: true,
    );

    final map = doctor.toMap();
    final restored = Doctor.fromMap('doc-1', map);

    expect(restored.id, 'doc-1');
    expect(restored.fullName, 'John Doe');
    expect(restored.specialty, 'Cardiology');
    expect(restored.department, 'Emergency');
    expect(restored.isAvailable, isTrue);
  });
}
