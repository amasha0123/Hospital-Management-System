import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/doctor.dart';
import 'doctor_provider.dart';

class DoctorEditPage extends ConsumerStatefulWidget {
  const DoctorEditPage({super.key, this.doctor});

  final Doctor? doctor;

  @override
  ConsumerState<DoctorEditPage> createState() => _DoctorEditPageState();
}

class _DoctorEditPageState extends ConsumerState<DoctorEditPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _specialtyController;
  late final TextEditingController _departmentController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final doctor = widget.doctor ?? const Doctor(
      id: '',
      doctorNumber: '',
      firstName: '',
      lastName: '',
      specialty: '',
      department: '',
      phone: '',
      email: '',
    );

    _firstNameController = TextEditingController(text: doctor.firstName);
    _lastNameController = TextEditingController(text: doctor.lastName);
    _specialtyController = TextEditingController(text: doctor.specialty);
    _departmentController = TextEditingController(text: doctor.department);
    _phoneController = TextEditingController(text: doctor.phone);
    _emailController = TextEditingController(text: doctor.email);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _specialtyController.dispose();
    _departmentController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final doctor = widget.doctor;
    if (doctor == null || doctor.id.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No doctor selected for editing.')),
      );
      return;
    }

    try {
      final repo = ref.read(doctorRepositoryProvider);
      await repo.updateDoctor(doctor.id, {
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'specialty': _specialtyController.text.trim(),
        'department': _departmentController.text.trim(),
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
      });

      ref.invalidate(doctorListProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Doctor updated successfully.')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update doctor: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Doctor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter first name.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter last name.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _specialtyController,
                decoration: const InputDecoration(labelText: 'Specialty *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter specialty.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _departmentController,
                decoration: const InputDecoration(labelText: 'Department *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter department.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone *'),
                keyboardType: TextInputType.phone,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter phone number.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email *'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter email.' : null,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _save,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
