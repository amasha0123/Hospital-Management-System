import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../presentation/auth/login_page.dart';
import '../presentation/dashboard/admin_dashboard.dart';
import '../presentation/dashboard/doctor_dashboard.dart';
import '../presentation/dashboard/nurse_dashboard.dart';
import '../presentation/dashboard/receptionist_dashboard.dart';
import '../presentation/dashboard/laboratory_dashboard.dart';
import '../presentation/dashboard/pharmacy_dashboard.dart';
import '../presentation/dashboard/accountant_dashboard.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) async {
      final container = ProviderScope.containerOf(context, listen: false);
      final user = container.read(currentUserProvider);
      if (user == null) {
        return '/login';
      }

      final profile = await container.read(currentUserProfileProvider.future);
      if (profile == null) {
        return '/login';
      }

      if (!profile.isActive) {
        return '/login';
      }

      switch (profile.role) {
        case 'ADMIN':
          return '/admin-dashboard';
        case 'DOCTOR':
          return '/doctor-dashboard';
        case 'NURSE':
          return '/nurse-dashboard';
        case 'RECEPTIONIST':
          return '/receptionist-dashboard';
        case 'LAB_STAFF':
          return '/laboratory-dashboard';
        case 'PHARMACIST':
          return '/pharmacy-dashboard';
        case 'ACCOUNTANT':
          return '/accountant-dashboard';
        default:
          return '/login';
      }
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/admin-dashboard', builder: (context, state) => const AdminDashboard()),
      GoRoute(path: '/doctor-dashboard', builder: (context, state) => const DoctorDashboard()),
      GoRoute(path: '/nurse-dashboard', builder: (context, state) => const NurseDashboard()),
      GoRoute(path: '/receptionist-dashboard', builder: (context, state) => const ReceptionistDashboard()),
      GoRoute(path: '/laboratory-dashboard', builder: (context, state) => const LaboratoryDashboard()),
      GoRoute(path: '/pharmacy-dashboard', builder: (context, state) => const PharmacyDashboard()),
      GoRoute(path: '/accountant-dashboard', builder: (context, state) => const AccountantDashboard()),
    ],
  );
}
