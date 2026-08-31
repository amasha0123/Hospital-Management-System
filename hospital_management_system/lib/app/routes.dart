import 'package:go_router/go_router.dart';
import '../presentation/appointments/add_appointment_page.dart';
import '../presentation/appointments/appointment_list_page.dart';
import '../presentation/auth/create_user_page.dart';
import '../presentation/auth/forgot_password_page.dart';
import '../presentation/auth/login_page.dart';
import '../presentation/dashboard/dashboard_page.dart';
import '../presentation/billing/add_billing_record_page.dart';
import '../presentation/billing/billing_list_page.dart';
import '../presentation/doctors/add_doctor_page.dart';
import '../presentation/doctors/doctor_list_page.dart';
import '../presentation/laboratory/add_lab_test_page.dart';
import '../presentation/laboratory/lab_test_list_page.dart';
import '../presentation/medical_records/add_medical_record_page.dart';
import '../presentation/medical_records/medical_record_list_page.dart';
import '../presentation/pharmacy/add_pharmacy_item_page.dart';
import '../presentation/pharmacy/pharmacy_list_page.dart';
import '../presentation/patients/add_patient_page.dart';
import '../presentation/reports/add_report_page.dart';
import '../presentation/reports/report_list_page.dart';
import '../presentation/staff/add_staff_member_page.dart';
import '../presentation/staff/staff_list_page.dart';
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
    GoRoute(path: '/doctors', builder: (ctx, state) => const DoctorListPage()),
    GoRoute(path: '/doctors/add', builder: (ctx, state) => const AddDoctorPage()),
    GoRoute(path: '/appointments', builder: (ctx, state) => const AppointmentListPage()),
    GoRoute(path: '/appointments/add', builder: (ctx, state) => const AddAppointmentPage()),
    GoRoute(path: '/medical-records', builder: (ctx, state) => const MedicalRecordListPage()),
    GoRoute(path: '/medical-records/add', builder: (ctx, state) => const AddMedicalRecordPage()),
    GoRoute(path: '/laboratory', builder: (ctx, state) => const LabTestListPage()),
    GoRoute(path: '/laboratory/add', builder: (ctx, state) => const AddLabTestPage()),
    GoRoute(path: '/pharmacy', builder: (ctx, state) => const PharmacyListPage()),
    GoRoute(path: '/pharmacy/add', builder: (ctx, state) => const AddPharmacyItemPage()),
    GoRoute(path: '/billing', builder: (ctx, state) => const BillingListPage()),
    GoRoute(path: '/billing/add', builder: (ctx, state) => const AddBillingRecordPage()),
    GoRoute(path: '/staff', builder: (ctx, state) => const StaffListPage()),
    GoRoute(path: '/staff/add', builder: (ctx, state) => const AddStaffMemberPage()),
    GoRoute(path: '/reports', builder: (ctx, state) => const ReportListPage()),
    GoRoute(path: '/reports/add', builder: (ctx, state) => const AddReportPage()),
  ],
);
