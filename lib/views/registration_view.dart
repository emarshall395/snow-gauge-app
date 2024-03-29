import 'package:flutter/material.dart';
import '../services/registration_service.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegistrationService _registrationService = RegistrationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Implement our registration logic here
                String name = _nameController.text;
                String email = _emailController.text;
                String password = _passwordController.text;

                bool success = await _registrationService.register(name, email, password);

                if (success) {
                  // Navigate to LeaderboardPage on successful registration
                  Navigator.pushReplacementNamed(context, '/leaderboard');
                } else {
                  // Handle failed registration, show an error message, etc.
                }
              },
              child: Text('Register'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate back to login page
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Already have an account? Login here.'),
            ),
          ],
        ),
      ),
    );
  }
}
