import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    await ref.read(authServiceProvider).signOut();
    if (context.mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProfileProvider).asData?.value;

    final cards = <_DashboardCardData>[
      _DashboardCardData(
        title: 'Manage Users',
        icon: Icons.people_alt_rounded,
        route: '/create-user',
        color: const Color(0xFF3B82F6),
        backgroundImage:
            'https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=900&q=80',
      ),
      _DashboardCardData(
        title: 'Patients',
        icon: Icons.people,
        route: '/patients',
        color: const Color(0xFF10B981),
        backgroundImage:
            'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=900&q=80',
      ),
      _DashboardCardData(
        title: 'Doctors',
        icon: Icons.medical_services,
        route: '/doctors',
        color: const Color(0xFF8B5CF6),
        backgroundImage:
            'https://images.unsplash.com/photo-1538108149393-fbbd81895973?auto=format&fit=crop&w=900&q=80',
      ),
      _DashboardCardData(
        title: 'Appointments',
        icon: Icons.calendar_month,
        route: '/appointments',
        color: const Color(0xFFF59E0B),
        backgroundImage:
            'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=900&q=80',
      ),
      _DashboardCardData(
        title: 'Attendance',
        icon: Icons.access_time_filled,
        route: '/attendance',
        color: const Color(0xFF14B8A6),
        backgroundImage:
            'https://images.unsplash.com/photo-1516549655169-df83a0774514?auto=format&fit=crop&w=900&q=80',
      ),
      _DashboardCardData(
        title: 'Leave',
        icon: Icons.event_busy,
        route: '/leave',
        color: const Color(0xFFEF4444),
        backgroundImage:
            'https://images.unsplash.com/photo-1532938911079-1b06ac7ceec7?auto=format&fit=crop&w=900&q=80',
      ),
      _DashboardCardData(
        title: 'Laboratory',
        icon: Icons.science,
        route: '/laboratory',
        color: const Color(0xFF06B6D4),
        backgroundImage:
            'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=900&q=80',
      ),
      _DashboardCardData(
        title: 'Pharmacy',
        icon: Icons.medication,
        route: '/pharmacy',
        color: const Color(0xFFEC4899),
        backgroundImage:
            'https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=900&q=80',
      ),
      _DashboardCardData(
        title: 'Billing',
        icon: Icons.receipt_long,
        route: '/billing',
        color: const Color(0xFF84CC16),
        backgroundImage:
            'https://images.unsplash.com/photo-1554224155-6726b3ff858f?auto=format&fit=crop&w=900&q=80',
      ),
      _DashboardCardData(
        title: 'Reports',
        icon: Icons.bar_chart,
        route: '/reports',
        color: const Color(0xFF6366F1),
        backgroundImage:
            'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=900&q=80',
      ),
    ];

    final menuItems = <_SidebarItemData>[
      _SidebarItemData(label: 'Dashboard', icon: Icons.dashboard, route: '/admin-dashboard'),
      _SidebarItemData(label: 'Manage Users', icon: Icons.people_alt_rounded, route: '/create-user'),
      _SidebarItemData(label: 'Patients', icon: Icons.people, route: '/patients'),
      _SidebarItemData(label: 'Doctors', icon: Icons.medical_services, route: '/doctors'),
      _SidebarItemData(label: 'Appointments', icon: Icons.calendar_month, route: '/appointments'),
      _SidebarItemData(label: 'Attendance', icon: Icons.access_time_filled, route: '/attendance'),
      _SidebarItemData(label: 'Leave Requests', icon: Icons.event_busy, route: '/leave'),
      _SidebarItemData(label: 'Medical Records', icon: Icons.folder_shared, route: '/medical-records'),
      _SidebarItemData(label: 'Laboratory', icon: Icons.science, route: '/laboratory'),
      _SidebarItemData(label: 'Pharmacy', icon: Icons.medication, route: '/pharmacy'),
      _SidebarItemData(label: 'Billing', icon: Icons.receipt_long, route: '/billing'),
      _SidebarItemData(label: 'Staff', icon: Icons.badge, route: '/staff'),
      _SidebarItemData(label: 'Reports', icon: Icons.bar_chart, route: '/reports'),
      _SidebarItemData(label: 'Security', icon: Icons.security, route: '/security'),
      _SidebarItemData(label: 'Backup & Recovery', icon: Icons.backup, route: '/backup-recovery'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          TextButton.icon(
            onPressed: () => _logout(context, ref),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Logout'),
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
                  colors: [Color(0xFF1D4ED8), Color(0xFF0EA5E9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'HMS Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ...menuItems.map((item) => ListTile(
                  leading: Icon(item.icon, color: const Color(0xFF2563EB)),
                  title: Text(item.label),
                  onTap: () {
                    Navigator.pop(context);
                    context.go(item.route);
                  },
                )),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/images/medical_dashboard.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF0F172A).withValues(alpha: 0.72),
                                const Color(0xFF1D4ED8).withValues(alpha: 0.38),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Hospital Management',
                                    style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 1.2),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Welcome back, ${user?.name ?? 'Administrator'}',
                                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Operations overview • Team status • revenue watch',
                                    style: TextStyle(color: Colors.white70, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Icon(Icons.local_hospital_rounded, color: Colors.white, size: 34),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const [
                  _SummaryMetricCard(label: 'Total Patients', value: '1,284', icon: Icons.people_alt_rounded, color: Color(0xFF3B82F6)),
                  _SummaryMetricCard(label: "Today's Appointments", value: '48', icon: Icons.calendar_today_rounded, color: Color(0xFF10B981)),
                  _SummaryMetricCard(label: 'Revenue Summary', value: 'Rs. 1.4L', icon: Icons.attach_money_rounded, color: Color(0xFFF59E0B)),
                  _SummaryMetricCard(label: 'Laboratory Requests', value: '23', icon: Icons.science_rounded, color: Color(0xFF06B6D4)),
                  _SummaryMetricCard(label: 'Pharmacy Alerts', value: '07', icon: Icons.medication_liquid_rounded, color: Color(0xFFEC4899)),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Quick Access',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF102A43)),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return _DashboardCard(
                    title: card.title,
                    icon: card.icon,
                    route: card.route,
                    color: card.color,
                    backgroundImage: card.backgroundImage,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryMetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryMetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF102A43))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItemData {
  final String label;
  final IconData icon;
  final String route;

  const _SidebarItemData({required this.label, required this.icon, required this.route});
}

class _DashboardCardData {
  final String title;
  final IconData icon;
  final String route;
  final Color color;
  final String backgroundImage;

  const _DashboardCardData({
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
    required this.backgroundImage,
  });
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final Color color;
  final String backgroundImage;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    final isAsset = backgroundImage.startsWith('assets/');

    return InkWell(
      onTap: () => context.go(route),
      borderRadius: BorderRadius.circular(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: isAsset
                  ? SvgPicture.asset(
                      backgroundImage,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      backgroundImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color.withValues(alpha: 0.86), Colors.black.withValues(alpha: 0.3)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.48),
                      Colors.black.withValues(alpha: 0.12),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, size: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
