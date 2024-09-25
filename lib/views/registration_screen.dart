import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/controllers/registration_controller.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final RegistrationController _registrationController = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _registrationController.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _registrationController.firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your First Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _registrationController.lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your Last Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _registrationController.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _registrationController.passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your password';
                  }
                  if (value!.length <= 6) {
                    return 'Password must be more than 6 letters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Obx(() => ElevatedButton(
                onPressed: _registrationController.isLoading.value
                    ? null
                    : () => _registrationController.register(context),
                child: _registrationController.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Register'),
              )),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('Already have an account? Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
