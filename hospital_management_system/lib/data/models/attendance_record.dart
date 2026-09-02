import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceRecord {
  final String id;
  final String employeeName;
  final String department;
  final String role;
  final DateTime date;
  final String checkIn;
  final String checkOut;
  final String status;
  final double hoursWorked;
  final String notes;

  const AttendanceRecord({
    required this.id,
    required this.employeeName,
    required this.department,
    required this.role,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.hoursWorked,
    required this.notes,
  });

  factory AttendanceRecord.fromMap(String id, Map<String, dynamic> map) {
    return AttendanceRecord(
      id: id,
      employeeName: map['employeeName'] ?? '',
      department: map['department'] ?? '',
      role: map['role'] ?? '',
      date: map['date'] is Timestamp
          ? (map['date'] as Timestamp).toDate()
          : DateTime.tryParse(map['date']?.toString() ?? '') ?? DateTime.now(),
      checkIn: map['checkIn'] ?? '09:00',
      checkOut: map['checkOut'] ?? '17:00',
      status: map['status'] ?? 'Present',
      hoursWorked: (map['hoursWorked'] as num?)?.toDouble() ?? 8.0,
      notes: map['notes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeName': employeeName,
      'department': department,
      'role': role,
      'date': Timestamp.fromDate(date),
      'checkIn': checkIn,
      'checkOut': checkOut,
      'status': status,
      'hoursWorked': hoursWorked,
      'notes': notes,
    };
  }
}
