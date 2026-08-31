import 'package:go_router/go_router.dart';
import '../presentation/auth/create_user_page.dart';
import '../presentation/auth/forgot_password_page.dart';
import '../presentation/auth/login_page.dart';
import '../presentation/dashboard/dashboard_page.dart';
import '../presentation/patients/add_patient_page.dart';
import '../presentation/patients/edit_patient_page.dart';
import '../presentation/patients/patient_details_page.dart';
import '../presentation/patients/patient_list_page.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (ctx, state) => const LoginPage()),
    GoRoute(path: '/forgot-password', builder: (ctx, state) => const ForgotPasswordPage()),
    GoRoute(path: '/create-user', builder: (ctx, state) => const CreateUserPage()),
    GoRoute(path: '/', builder: (ctx, state) => const DashboardPage()),
    GoRoute(path: '/patients', builder: (ctx, state) => const PatientListPage()),
    GoRoute(path: '/patients/add', builder: (ctx, state) => const AddPatientPage()),
    GoRoute(path: '/patients/details', builder: (ctx, state) => const PatientDetailsPage()),
    GoRoute(path: '/patients/edit', builder: (ctx, state) => const EditPatientPage()),
  ],
);
