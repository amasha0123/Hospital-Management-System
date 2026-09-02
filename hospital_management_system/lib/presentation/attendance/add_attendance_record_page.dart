import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/attendance_record.dart';
import 'attendance_provider.dart';

class AddAttendanceRecordPage extends ConsumerStatefulWidget {
  const AddAttendanceRecordPage({super.key});

  @override
  ConsumerState<AddAttendanceRecordPage> createState() => _AddAttendanceRecordPageState();
}

class _AddAttendanceRecordPageState extends ConsumerState<AddAttendanceRecordPage> {
  final _formKey = GlobalKey<FormState>();
  final _employeeNameController = TextEditingController();
  final _departmentController = TextEditingController();
  final _roleController = TextEditingController();
  final _checkInController = TextEditingController(text: '09:00');
  final _checkOutController = TextEditingController(text: '17:00');
  final _statusController = TextEditingController(text: 'Present');
  final _notesController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _employeeNameController.dispose();
    _departmentController.dispose();
    _roleController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    _statusController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    try {
      final repo = ref.read(attendanceRepositoryProvider);
      final record = AttendanceRecord(
        id: '',
        employeeName: _employeeNameController.text.trim(),
        department: _departmentController.text.trim(),
        role: _roleController.text.trim(),
        date: DateTime.now(),
        checkIn: _checkInController.text.trim(),
        checkOut: _checkOutController.text.trim(),
        status: _statusController.text.trim(),
        hoursWorked: 8.0,
        notes: _notesController.text.trim(),
      );

      await repo.createAttendanceRecord(record);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Attendance saved successfully.')),
        );
        ref.invalidate(attendanceListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save attendance: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Attendance Record')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _employeeNameController,
                decoration: const InputDecoration(labelText: 'Employee Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _departmentController,
                decoration: const InputDecoration(labelText: 'Department *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _roleController,
                decoration: const InputDecoration(labelText: 'Role *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _checkInController,
                decoration: const InputDecoration(labelText: 'Check In'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _checkOutController,
                decoration: const InputDecoration(labelText: 'Check Out'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _saving ? null : _submit,
                child: _saving
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Save Attendance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
