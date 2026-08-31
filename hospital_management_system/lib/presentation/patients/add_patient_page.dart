import 'package:flutter/material.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({super.key});

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController(text: 'Male');

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Patient')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter patient name.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter patient last name.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone *'),
                keyboardType: TextInputType.phone,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter phone number.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter gender.' : null,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Patient registered successfully.')),
                    );
                  }
                },
                child: const Text('Register Patient'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
