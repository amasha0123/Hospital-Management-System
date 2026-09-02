import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/appointment.dart';
import 'appointment_provider.dart';

class AddAppointmentPage extends ConsumerStatefulWidget {
  const AddAppointmentPage({super.key});

  @override
  ConsumerState<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends ConsumerState<AddAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _reasonController = TextEditingController();
  final List<String> _doctorOptions = [
    'Dr. Sarah Johnson',
    'Dr. Daniel Lee',
    'Dr. Priya Nair',
    'Dr. Michael Chen',
  ];
  DateTime _selectedDate = DateTime.now();
  String _selectedDoctor = 'Dr. Sarah Johnson';
  bool _saving = false;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final repo = ref.read(appointmentRepositoryProvider);

    try {
      final appointment = Appointment(
        id: '',
        appointmentNumber: 'APT${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        patientId: 'P${DateTime.now().millisecondsSinceEpoch}',
        patientName: _patientNameController.text.trim(),
        doctorId: 'D${DateTime.now().millisecondsSinceEpoch}',
        doctorName: _selectedDoctor,
        appointmentDate: _selectedDate,
        status: 'Scheduled',
        reason: _reasonController.text.trim(),
      );

      await repo.createAppointment(appointment);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment booked successfully.')),
        );
        ref.invalidate(appointmentListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save appointment: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _patientNameController,
                decoration: const InputDecoration(labelText: 'Patient Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter patient name.' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedDoctor,
                decoration: const InputDecoration(labelText: 'Doctor Selection *'),
                items: _doctorOptions
                    .map((doctor) => DropdownMenuItem(value: doctor, child: Text(doctor)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedDoctor = value);
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                title: const Text('Appointment Date'),
                subtitle: Text(_selectedDate.toLocal().toString().split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _reasonController,
                decoration: const InputDecoration(labelText: 'Reason *'),
                minLines: 2,
                maxLines: 4,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter reason.' : null,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _saving ? null : _submit,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Book Appointment'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
