import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardStats {
  final int patients;
  final int appointments;
  final double revenue;
  final int labRequests;
  final int pharmacyAlerts;

  const DashboardStats({
    required this.patients,
    required this.appointments,
    required this.revenue,
    required this.labRequests,
    required this.pharmacyAlerts,
  });
}

final dashboardStatsProvider = Provider<DashboardStats>((ref) {
  return const DashboardStats(
    patients: 1250,
    appointments: 45,
    revenue: 450000,
    labRequests: 18,
    pharmacyAlerts: 7,
  );
});
