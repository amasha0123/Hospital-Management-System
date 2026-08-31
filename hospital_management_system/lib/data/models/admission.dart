import 'package:cloud_firestore/cloud_firestore.dart';

class Admission {
  final String id;
  final String admissionNumber;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final String ward;
  final String bedNumber;
  final DateTime admissionDate;
  final DateTime? dischargeDate;
  final String reason;
  final String status;

  const Admission({
    required this.id,
    required this.admissionNumber,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.ward,
    required this.bedNumber,
    required this.admissionDate,
    this.dischargeDate,
    required this.reason,
    required this.status,
  });

  factory Admission.fromMap(String id, Map<String, dynamic> map) {
    return Admission(
      id: id,
      admissionNumber: map['admissionNumber'] ?? '',
      patientId: map['patientId'] ?? '',
      patientName: map['patientName'] ?? '',
      doctorId: map['doctorId'] ?? '',
      doctorName: map['doctorName'] ?? '',
      ward: map['ward'] ?? '',
      bedNumber: map['bedNumber'] ?? '',
      admissionDate: (map['admissionDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      dischargeDate: (map['dischargeDate'] as Timestamp?)?.toDate(),
      reason: map['reason'] ?? '',
      status: map['status'] ?? 'Admitted',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'admissionNumber': admissionNumber,
      'patientId': patientId,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'ward': ward,
      'bedNumber': bedNumber,
      'admissionDate': Timestamp.fromDate(admissionDate),
      'dischargeDate': dischargeDate == null ? null : Timestamp.fromDate(dischargeDate!),
      'reason': reason,
      'status': status,
    };
  }
}
