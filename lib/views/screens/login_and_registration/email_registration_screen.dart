import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mojtrsat/providers/auth_providers.dart';

class EmailRegistrationScreen extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  EmailRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationViewModel = ref.watch(registrationViewModelProvider.notifier);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Column(
        children: [
          // Gornji crni dio sa sredinom
          SizedBox(
            height: height * 0.45,
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Registracija',
                    style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Unesite vaš email i lozinku',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          // Donji container drugačije boje
          Expanded(
            child: Container(
              color: const Color(0xFF1C1C1E),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInputField(controller: emailController, hint: ' Email'),
                  const SizedBox(height: 16),
                  _buildInputField(controller: passwordController, hint: 'Lozinka', obscureText: true),
                  const SizedBox(height: 16),
                  _buildInputField(controller: confirmPasswordController, hint: 'Ponovite lozinku', obscureText: true),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = emailController.text;
                        final password = passwordController.text;
                        final confirm = confirmPasswordController.text;

                        if (password != confirm) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Lozinke se ne podudaraju')),
                          );
                          return;
                        }

                        final success = await registrationViewModel.signup(email, password);
                        if (success) {
                          context.push('/registration/uniri_credentials');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registracija nije uspjela')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white60,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                        elevation: 0,
                      ),
                      child: const Text('Napravi račun', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Slažem se s ", style: TextStyle(color: Colors.white38, fontSize: 12)),
                          TextSpan(text: "Uvjetima korištenja", style: TextStyle(color: Colors.blue, fontSize: 12)),
                          TextSpan(text: " i ", style: TextStyle(color: Colors.white38, fontSize: 12)),
                          TextSpan(text: "Pravilima privatnosti.", style: TextStyle(color: Colors.blue, fontSize: 12)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),

                
                  const SizedBox(height: 24),

                  // Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Vec imate račun?", style: TextStyle(color: Colors.white70)),
                      TextButton(
                        onPressed: () => context.push('/login'),
                        child: const Text('Prijava', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF2C2C2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }


}
