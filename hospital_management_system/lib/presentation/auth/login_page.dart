import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      final auth = ref.read(authServiceProvider);
      final credential = await auth.signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );

      final uid = credential.user?.uid;
      if (uid == null) {
        throw StateError('Authentication failed.');
      }

      final user = await auth.getAuthenticatedUserProfile(uid);

      if (!mounted) return;

      switch (user.role) {
        case 'ADMIN':
          context.go('/admin-dashboard');
          break;
        case 'DOCTOR':
          context.go('/doctor-dashboard');
          break;
        case 'NURSE':
          context.go('/nurse-dashboard');
          break;
        case 'RECEPTIONIST':
          context.go('/receptionist-dashboard');
          break;
        case 'LAB_STAFF':
          context.go('/laboratory-dashboard');
          break;
        case 'PHARMACIST':
          context.go('/pharmacy-dashboard');
          break;
        case 'ACCOUNTANT':
          context.go('/accountant-dashboard');
          break;
        default:
          throw StateError('Invalid role for this account.');
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_messageForFirebaseError(e.code))),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _messageForFirebaseError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account exists for this email.';
      case 'wrong-password':
        return 'The password is incorrect.';
      default:
        return 'Login failed. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/medical_login.svg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.18),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white.withValues(alpha: 0.9),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.local_hospital_rounded, size: 42, color: Color(0xFF2563EB)),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Hospital Management System',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF102A43)),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sign in to continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(labelText: 'Username'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter username' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) => (value == null || value.isEmpty) ? 'Enter password' : null,
                          ),
                          const SizedBox(height: 20),
                          _loading
                              ? const Center(child: CircularProgressIndicator())
                              : FilledButton(
                                  onPressed: _submit,
                                  child: const Text('Login'),
                                ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () => context.push('/forgot-password'),
                            child: const Text('Forgot password?'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
