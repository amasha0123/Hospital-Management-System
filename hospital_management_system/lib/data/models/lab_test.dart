import 'package:cloud_firestore/cloud_firestore.dart';

class LabTest {
  final String id;
  final String testCode;
  final String patientName;
  final String doctorName;
  final String testName;
  final String status;
  final String notes;
  final DateTime requestedAt;
  final bool isCompleted;

  const LabTest({
    required this.id,
    required this.testCode,
    required this.patientName,
    required this.doctorName,
    required this.testName,
    required this.status,
    required this.notes,
    required this.requestedAt,
    this.isCompleted = false,
  });

  factory LabTest.fromMap(String id, Map<String, dynamic> map) {
    return LabTest(
      id: id,
      testCode: map['testCode'] ?? '',
      patientName: map['patientName'] ?? '',
      doctorName: map['doctorName'] ?? '',
      testName: map['testName'] ?? '',
      status: map['status'] ?? 'Pending',
      notes: map['notes'] ?? '',
      requestedAt: map['requestedAt'] is Timestamp
          ? (map['requestedAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['requestedAt']?.toString() ?? '') ?? DateTime.now(),
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'testCode': testCode,
      'patientName': patientName,
      'doctorName': doctorName,
      'testName': testName,
      'status': status,
      'notes': notes,
      'requestedAt': Timestamp.fromDate(requestedAt),
      'isCompleted': isCompleted,
    };
  }
}
