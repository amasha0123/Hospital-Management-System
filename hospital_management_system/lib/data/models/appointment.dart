import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String appointmentNumber;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final DateTime appointmentDate;
  final String status;
  final String reason;

  const Appointment({
    required this.id,
    required this.appointmentNumber,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.appointmentDate,
    required this.status,
    required this.reason,
  });

  factory Appointment.fromMap(String id, Map<String, dynamic> map) {
    return Appointment(
      id: id,
      appointmentNumber: map['appointmentNumber'] ?? '',
      patientId: map['patientId'] ?? '',
      patientName: map['patientName'] ?? '',
      doctorId: map['doctorId'] ?? '',
      doctorName: map['doctorName'] ?? '',
      appointmentDate: (map['appointmentDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: map['status'] ?? 'Scheduled',
      reason: map['reason'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appointmentNumber': appointmentNumber,
      'patientId': patientId,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'appointmentDate': appointmentDate,
      'status': status,
      'reason': reason,
    };
  }
}
