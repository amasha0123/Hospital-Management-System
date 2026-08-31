import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_provider.dart';
import 'dashboard_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(dashboardStatsProvider);
    final role = ref.watch(userRoleProvider);
    final isDoctor = role == 'DOCTOR';

    final quickActions = [
      _QuickAction(icon: Icons.people, label: 'Patients', route: '/patients'),
      _QuickAction(icon: Icons.medical_services, label: 'Doctors', route: '/doctors'),
      _QuickAction(icon: Icons.calendar_month, label: 'Appointments', route: '/appointments'),
      _QuickAction(icon: Icons.folder_shared, label: 'Records', route: '/medical-records'),
    ];

    final recentActivity = [
      _ActivityItem(title: '13 new patient registrations', time: '2 hours ago', color: Colors.blue),
      _ActivityItem(title: 'Lab report pending review', time: '1 hour ago', color: Colors.orange),
      _ActivityItem(title: 'Pharmacy restock alert', time: '30 min ago', color: Colors.green),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Hospital Management System', style: TextStyle(fontSize: 18)),
            Text('Operations Overview', style: TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => context.push('/notifications'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                'HMS',
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Patients'),
              onTap: () {
                Navigator.pop(context);
                context.go('/patients');
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('Doctors'),
              onTap: () {
                Navigator.pop(context);
                context.go('/doctors');
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Appointments'),
              onTap: () {
                Navigator.pop(context);
                context.go('/appointments');
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_shared),
              title: const Text('Medical Records'),
              onTap: () {
                Navigator.pop(context);
                context.go('/medical-records');
              },
            ),
            ListTile(
              leading: const Icon(Icons.science),
              title: const Text('Laboratory'),
              onTap: () {
                Navigator.pop(context);
                context.go('/laboratory');
              },
            ),
            ListTile(
              leading: const Icon(Icons.medication),
              title: const Text('Pharmacy'),
              onTap: () {
                Navigator.pop(context);
                context.go('/pharmacy');
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Billing'),
              onTap: () {
                Navigator.pop(context);
                context.go('/billing');
              },
            ),
            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('Staff'),
              onTap: () {
                Navigator.pop(context);
                context.go('/staff');
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Reports'),
              onTap: () {
                Navigator.pop(context);
                context.go('/reports');
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
                context.go('/notifications');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Audit Logs'),
              onTap: () {
                Navigator.pop(context);
                context.go('/audit-logs');
              },
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Security'),
              onTap: () {
                Navigator.pop(context);
                context.go('/security');
              },
            ),
            ListTile(
              leading: const Icon(Icons.vpn_key),
              title: const Text('Password Management'),
              onTap: () {
                Navigator.pop(context);
                context.go('/password-management');
              },
            ),
            ListTile(
              leading: const Icon(Icons.backup),
              title: const Text('Backup & Recovery'),
              onTap: () {
                Navigator.pop(context);
                context.go('/backup-recovery');
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isDoctor ? 'Good day, Doctor' : 'Good day, Administrator',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isDoctor
                                ? 'Your patient care summary is ready.'
                                : 'Your hospital performance overview is ready.',
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.local_hospital_rounded, color: Colors.white, size: 54),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.7,
                children: [
                  _MetricCard(label: 'Patients', value: '${stats.patients}', icon: Icons.people_alt_rounded, accent: const Color(0xFF3B82F6)),
                  _MetricCard(label: 'Appointments', value: '${stats.appointments}', icon: Icons.calendar_today_rounded, accent: const Color(0xFF10B981)),
                  _MetricCard(label: 'Revenue', value: 'Rs.${stats.revenue.toStringAsFixed(0)}', icon: Icons.attach_money_rounded, accent: const Color(0xFFF59E0B)),
                  _MetricCard(label: isDoctor ? 'Pending Reports' : 'Lab Requests', value: '${stats.labRequests}', icon: Icons.analytics_rounded, accent: const Color(0xFF8B5CF6)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _InfoPanel(
                      title: isDoctor ? 'Follow-ups' : 'Pharmacy Alerts',
                      value: '${stats.pharmacyAlerts}',
                      icon: Icons.inventory_2_outlined,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _InfoPanel(
                      title: 'System Health',
                      value: '98.4%',
                      icon: Icons.health_and_safety_outlined,
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Icon(Icons.flash_on_rounded, color: Colors.blue),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: quickActions.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final action = quickActions[index];
                          return InkWell(
                            onTap: () => context.go(action.route),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(action.icon, color: const Color(0xFF2563EB)),
                                  const SizedBox(height: 8),
                                  Text(
                                    action.label,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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
                    children: [
                      const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ...recentActivity.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: item.color,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                                      Text(item.time, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color accent;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: accent),
            ),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
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
  final IconData icon;

  const _InfoPanel({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2FE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF0284C7)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final String route;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.route,
  });
}

class _ActivityItem {
  final String title;
  final String time;
  final Color color;

  const _ActivityItem({
    required this.title,
    required this.time,
    required this.color,
  });
}
