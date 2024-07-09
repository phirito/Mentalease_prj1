// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SignUpArea extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _mnameController = TextEditingController();
  final TextEditingController _studIDController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signup() {
    if (_formKey.currentState!.validate()) {
      // Perform login action
    }
  }

  SignUpArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign-Up"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _lnameController,
                decoration: InputDecoration(
                  labelText: "Last Name",
                  hintText: "Enter Last Name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fnameController,
                decoration: InputDecoration(
                  labelText: "First Name",
                  hintText: "Enter First Name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mnameController,
                decoration: InputDecoration(
                  labelText: "Middle Name",
                  hintText: "Enter Middle Name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your middle name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _studIDController,
                decoration: InputDecoration(
                  labelText: "Student ID",
                  hintText: "Enter Student ID",
                  prefixIcon: const Icon(Icons.school),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your student ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "Confirm password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2))),
                child: const Text("Sign-Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
