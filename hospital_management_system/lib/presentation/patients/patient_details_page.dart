import 'package:flutter/material.dart';

class PatientDetailsPage extends StatelessWidget {
  const PatientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Details')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('John Perera', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Patient ID: P001'),
            SizedBox(height: 20),
            Text('DOB: 12/05/1980'),
            Text('Gender: Male'),
            Text('Blood Group: O+'),
            Text('Phone: 077xxxxxxx'),
          ],
        ),
      ),
    );
  }
}
