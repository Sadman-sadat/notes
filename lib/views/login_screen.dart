import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _loginController  = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _loginController.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _loginController.emailController,
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
                controller: _loginController.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
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
                onPressed: _loginController.isLoading.value
                    ? null
                    : () => _loginController.login(context),
                child: _loginController.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              )),
              TextButton(
                onPressed: () {
                  context.go('/register');
                },
                child: const Text('Register'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
