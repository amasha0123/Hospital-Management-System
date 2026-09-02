import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/patient.dart';

class PatientDetailsPage extends StatelessWidget {
  const PatientDetailsPage({super.key, this.patient});

  final Patient? patient;

  @override
  Widget build(BuildContext context) {
    final selectedPatient = patient ?? const Patient(
      id: '',
      patientNumber: 'N/A',
      firstName: 'No',
      lastName: 'Patient',
      gender: 'N/A',
      phone: 'N/A',
      email: 'N/A',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        actions: [
          IconButton(
            onPressed: () => context.push('/patients/edit', extra: selectedPatient),
            icon: const Icon(Icons.edit_rounded),
            tooltip: 'Edit patient',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1D4ED8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white.withValues(alpha: 0.18),
                      child: Text(
                        selectedPatient.firstName.isNotEmpty ? selectedPatient.firstName[0].toUpperCase() : 'P',
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedPatient.fullName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Patient ID: ${selectedPatient.patientNumber}',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _InfoTile(label: 'Gender', value: selectedPatient.gender),
                  _InfoTile(label: 'Phone', value: selectedPatient.phone),
                  _InfoTile(label: 'Email', value: selectedPatient.email.isEmpty ? 'Not provided' : selectedPatient.email),
                  _InfoTile(
                    label: 'Status',
                    value: selectedPatient.isActive ? 'Active' : 'Inactive',
                    accent: selectedPatient.isActive ? const Color(0xFFDCFCE7) : const Color(0xFFFEF2F2),
                    textColor: selectedPatient.isActive ? const Color(0xFF166534) : const Color(0xFF991B1B),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => context.push('/patients/edit', extra: selectedPatient),
                      icon: const Icon(Icons.edit_rounded),
                      label: const Text('Edit Patient'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.history_rounded),
                      label: const Text('View History'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Clinical History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF102A43)),
              ),
              const SizedBox(height: 12),
              _HistoryCard(title: 'Consultation', detail: 'Reviewed blood pressure and advised lifestyle modifications.'),
              const SizedBox(height: 10),
              _HistoryCard(title: 'Lab Follow-up', detail: 'CBC and fasting sugar reviewed; results normal.'),
              const SizedBox(height: 10),
              _HistoryCard(title: 'Medication', detail: 'Prescription renewed for 30 days with hydration guidance.'),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final String title;
  final String detail;

  const _HistoryCard({required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF102A43))),
          const SizedBox(height: 6),
          Text(detail, style: const TextStyle(color: Colors.black54, height: 1.4)),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.label,
    required this.value,
    this.accent,
    this.textColor,
  });

  final String label;
  final String value;
  final Color? accent;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: accent ?? const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: textColor ?? const Color(0xFF0F172A),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
