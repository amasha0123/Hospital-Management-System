import 'package:go_router/go_router.dart';
import '../data/models/doctor.dart';
import '../data/models/patient.dart';
import '../presentation/appointments/add_appointment_page.dart';
import '../presentation/appointments/appointment_list_page.dart';
import '../presentation/attendance/add_attendance_record_page.dart';
import '../presentation/attendance/attendance_list_page.dart';
import '../presentation/audit_logs/add_audit_log_page.dart';
import '../presentation/audit_logs/audit_log_list_page.dart';
import '../presentation/auth/create_user_page.dart';
import '../presentation/auth/forgot_password_page.dart';
import '../presentation/auth/login_page.dart';
import '../presentation/auth/password_management_page.dart';
import '../presentation/dashboard/accountant_dashboard.dart';
import '../presentation/dashboard/admin_dashboard.dart';
import '../presentation/dashboard/dashboard_page.dart';
import '../presentation/dashboard/doctor_dashboard.dart';
import '../presentation/dashboard/laboratory_dashboard.dart';
import '../presentation/dashboard/nurse_dashboard.dart';
import '../presentation/dashboard/pharmacy_dashboard.dart';
import '../presentation/dashboard/receptionist_dashboard.dart';
import '../presentation/departments/add_department_page.dart';
import '../presentation/departments/department_list_page.dart';
import '../presentation/admissions/add_admission_page.dart';
import '../presentation/admissions/admission_list_page.dart';
import '../presentation/billing/add_billing_record_page.dart';
import '../presentation/billing/billing_list_page.dart';
import '../presentation/doctors/add_doctor_page.dart';
import '../presentation/doctors/doctor_details_page.dart';
import '../presentation/doctors/doctor_edit_page.dart';
import '../presentation/doctors/doctor_list_page.dart';
import '../presentation/leave/add_leave_request_page.dart';
import '../presentation/leave/leave_list_page.dart';
import '../presentation/laboratory/add_lab_test_page.dart';
import '../presentation/laboratory/lab_test_list_page.dart';
import '../presentation/medical_records/add_medical_record_page.dart';
import '../presentation/medical_records/medical_record_list_page.dart';
import '../presentation/notifications/add_notification_page.dart';
import '../presentation/notifications/notification_list_page.dart';
import '../presentation/pharmacy/add_pharmacy_item_page.dart';
import '../presentation/pharmacy/pharmacy_list_page.dart';
import '../presentation/patients/add_patient_page.dart';
import '../presentation/reports/add_report_page.dart';
import '../presentation/reports/report_list_page.dart';
import '../presentation/security/add_security_event_page.dart';
import '../presentation/security/backup_recovery_page.dart';
import '../presentation/security/security_event_list_page.dart';
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
    GoRoute(path: '/admin-dashboard', builder: (ctx, state) => const AdminDashboard()),
    GoRoute(path: '/doctor-dashboard', builder: (ctx, state) => const DoctorDashboard()),
    GoRoute(path: '/nurse-dashboard', builder: (ctx, state) => const NurseDashboard()),
    GoRoute(path: '/receptionist-dashboard', builder: (ctx, state) => const ReceptionistDashboard()),
    GoRoute(path: '/laboratory-dashboard', builder: (ctx, state) => const LaboratoryDashboard()),
    GoRoute(path: '/pharmacy-dashboard', builder: (ctx, state) => const PharmacyDashboard()),
    GoRoute(path: '/accountant-dashboard', builder: (ctx, state) => const AccountantDashboard()),
    GoRoute(path: '/patients', builder: (ctx, state) => const PatientListPage()),
    GoRoute(path: '/patients/add', builder: (ctx, state) => const AddPatientPage()),
    GoRoute(
      path: '/patients/details',
      builder: (ctx, state) => PatientDetailsPage(patient: state.extra as Patient?),
    ),
    GoRoute(
      path: '/patients/edit',
      builder: (ctx, state) => EditPatientPage(patient: state.extra as Patient?),
    ),
    GoRoute(path: '/doctors', builder: (ctx, state) => const DoctorListPage()),
    GoRoute(path: '/doctors/add', builder: (ctx, state) => const AddDoctorPage()),
    GoRoute(
      path: '/doctors/details',
      builder: (ctx, state) => DoctorDetailsPage(doctor: state.extra as Doctor?),
    ),
    GoRoute(
      path: '/doctors/edit',
      builder: (ctx, state) => DoctorEditPage(doctor: state.extra as Doctor?),
    ),
    GoRoute(path: '/appointments', builder: (ctx, state) => const AppointmentListPage()),
    GoRoute(path: '/appointments/add', builder: (ctx, state) => const AddAppointmentPage()),
    GoRoute(path: '/medical-records', builder: (ctx, state) => const MedicalRecordListPage()),
    GoRoute(path: '/medical-records/add', builder: (ctx, state) => const AddMedicalRecordPage()),
    GoRoute(path: '/departments', builder: (ctx, state) => const DepartmentListPage()),
    GoRoute(path: '/departments/add', builder: (ctx, state) => const AddDepartmentPage()),
    GoRoute(path: '/admissions', builder: (ctx, state) => const AdmissionListPage()),
    GoRoute(path: '/admissions/add', builder: (ctx, state) => const AddAdmissionPage()),
    GoRoute(path: '/laboratory', builder: (ctx, state) => const LabTestListPage()),
    GoRoute(path: '/laboratory/add', builder: (ctx, state) => const AddLabTestPage()),
    GoRoute(path: '/pharmacy', builder: (ctx, state) => const PharmacyListPage()),
    GoRoute(path: '/pharmacy/add', builder: (ctx, state) => const AddPharmacyItemPage()),
    GoRoute(path: '/billing', builder: (ctx, state) => const BillingListPage()),
    GoRoute(path: '/billing/add', builder: (ctx, state) => const AddBillingRecordPage()),
    GoRoute(path: '/attendance', builder: (ctx, state) => const AttendanceListPage()),
    GoRoute(path: '/attendance/add', builder: (ctx, state) => const AddAttendanceRecordPage()),
    GoRoute(path: '/leave', builder: (ctx, state) => const LeaveListPage()),
    GoRoute(path: '/leave/add', builder: (ctx, state) => const AddLeaveRequestPage()),
    GoRoute(path: '/staff', builder: (ctx, state) => const StaffListPage()),
    GoRoute(path: '/staff/add', builder: (ctx, state) => const AddStaffMemberPage()),
    GoRoute(path: '/reports', builder: (ctx, state) => const ReportListPage()),
    GoRoute(path: '/reports/add', builder: (ctx, state) => const AddReportPage()),
    GoRoute(path: '/notifications', builder: (ctx, state) => const NotificationListPage()),
    GoRoute(path: '/notifications/add', builder: (ctx, state) => const AddNotificationPage()),
    GoRoute(path: '/audit-logs', builder: (ctx, state) => const AuditLogListPage()),
    GoRoute(path: '/audit-logs/add', builder: (ctx, state) => const AddAuditLogPage()),
    GoRoute(path: '/security', builder: (ctx, state) => const SecurityEventListPage()),
    GoRoute(path: '/security/add', builder: (ctx, state) => const AddSecurityEventPage()),
    GoRoute(path: '/password-management', builder: (ctx, state) => const PasswordManagementPage()),
    GoRoute(path: '/backup-recovery', builder: (ctx, state) => const BackupRecoveryPage()),
  ],
);
