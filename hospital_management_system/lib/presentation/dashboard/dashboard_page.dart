import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(dashboardStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Management System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Welcome, Administrator',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.2,
              children: [
                _MetricCard(label: 'Patients', value: '${stats.patients}', icon: Icons.people),
                _MetricCard(label: 'Appointments', value: '${stats.appointments}', icon: Icons.calendar_today),
                _MetricCard(label: 'Revenue', value: 'Rs.${stats.revenue.toStringAsFixed(0)}', icon: Icons.attach_money),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _InfoPanel(
                    title: 'Laboratory Requests',
                    value: '${stats.labRequests}',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _InfoPanel(
                    title: 'Pharmacy Alerts',
                    value: '${stats.pharmacyAlerts}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Appointment Chart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    SizedBox(height: 12),
                    Placeholder(fallbackHeight: 160),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Revenue Chart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    SizedBox(height: 12),
                    Placeholder(fallbackHeight: 160),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  final String title;
  final String value;

  const _InfoPanel({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
