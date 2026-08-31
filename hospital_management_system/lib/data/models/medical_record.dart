import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalRecord {
  final String id;
  final String recordNumber;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final String diagnosis;
  final String treatment;
  final String notes;
  final DateTime createdAt;

  const MedicalRecord({
    required this.id,
    required this.recordNumber,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.diagnosis,
    required this.treatment,
    required this.notes,
    required this.createdAt,
  });

  factory MedicalRecord.fromMap(String id, Map<String, dynamic> map) {
    return MedicalRecord(
      id: id,
      recordNumber: map['recordNumber'] ?? '',
      patientId: map['patientId'] ?? '',
      patientName: map['patientName'] ?? '',
      doctorId: map['doctorId'] ?? '',
      doctorName: map['doctorName'] ?? '',
      diagnosis: map['diagnosis'] ?? '',
      treatment: map['treatment'] ?? '',
      notes: map['notes'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recordNumber': recordNumber,
      'patientId': patientId,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'diagnosis': diagnosis,
      'treatment': treatment,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
