import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/doctor.dart';

class DoctorDetailsPage extends StatelessWidget {
  const DoctorDetailsPage({super.key, this.doctor});

  final Doctor? doctor;

  @override
  Widget build(BuildContext context) {
    final selectedDoctor = doctor ?? const Doctor(
      id: '',
      doctorNumber: 'N/A',
      firstName: 'No',
      lastName: 'Doctor',
      specialty: 'N/A',
      department: 'N/A',
      phone: 'N/A',
      email: 'N/A',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
        actions: [
          IconButton(
            onPressed: () => context.push('/doctors/edit', extra: selectedDoctor),
            icon: const Icon(Icons.edit),
            tooltip: 'Edit doctor',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selectedDoctor.fullName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Doctor ID: ${selectedDoctor.doctorNumber}'),
            const SizedBox(height: 16),
            Text('Specialty: ${selectedDoctor.specialty}'),
            Text('Department: ${selectedDoctor.department}'),
            Text('Phone: ${selectedDoctor.phone}'),
            Text('Email: ${selectedDoctor.email}'),
            const SizedBox(height: 20),
            Chip(
              label: Text(selectedDoctor.isAvailable ? 'Available' : 'Busy'),
            ),
          ],
        ),
      ),
    );
  }
}
