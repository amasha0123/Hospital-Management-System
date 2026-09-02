import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveRequest {
  final String id;
  final String employeeName;
  final String department;
  final String role;
  final DateTime startDate;
  final DateTime endDate;
  final String leaveType;
  final String status;
  final String reason;

  const LeaveRequest({
    required this.id,
    required this.employeeName,
    required this.department,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.leaveType,
    required this.status,
    required this.reason,
  });

  factory LeaveRequest.fromMap(String id, Map<String, dynamic> map) {
    return LeaveRequest(
      id: id,
      employeeName: map['employeeName'] ?? '',
      department: map['department'] ?? '',
      role: map['role'] ?? '',
      startDate: map['startDate'] is Timestamp
          ? (map['startDate'] as Timestamp).toDate()
          : DateTime.tryParse(map['startDate']?.toString() ?? '') ?? DateTime.now(),
      endDate: map['endDate'] is Timestamp
          ? (map['endDate'] as Timestamp).toDate()
          : DateTime.tryParse(map['endDate']?.toString() ?? '') ?? DateTime.now(),
      leaveType: map['leaveType'] ?? 'Annual',
      status: map['status'] ?? 'Pending',
      reason: map['reason'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeName': employeeName,
      'department': department,
      'role': role,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'leaveType': leaveType,
      'status': status,
      'reason': reason,
    };
  }
}
