import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mojtrsat/providers/auth_providers.dart';

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationViewModel = ref.watch(registrationViewModelProvider.notifier);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200, left: 32, right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Napravi račun',
                  style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Započni svoje stanovanje na Trsatu',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.45, 
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
              decoration: const BoxDecoration(
                color: Color(0xFF1C1C1E), 
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   _buildButton(
                    iconAsset: 'assets/images/google_icon.png',
                    text: 'Continue in with Google',
                    onPressed: () async {
                      try {
                        await registrationViewModel.signUpWithGoogle();
                        context.push('/registration/uniri_credentials');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Google Sign-In failed: $e')),
                        );
                      }
                    },
                    
                  ),
                  const SizedBox(height: 16),
                  _buildButton(
                    icon: Icons.apple,
                    text: 'Sign in with Apple',
                    onPressed: () {},
                  ),
                 
                  const SizedBox(height: 16),
                  _buildButton(
                    icon: Icons.mail_outline,
                    text: 'Sign Up with Email',
                    backgroundColor: const Color(0xFF007AFF),
                    textColor: Colors.white,
                    onPressed: () {
                      context.push('/registration/email_registration');
                    },
                  ),
                  const SizedBox(height: 24),
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
                  const SizedBox(height: 8),
                  const Text.rich(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    IconData? icon,
    String? iconAsset,
    required String text,
    required VoidCallback onPressed,
    Color backgroundColor = const Color(0xFF2C2C2E),
    Color textColor = Colors.white,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, size: 20),
            if (iconAsset != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(iconAsset, height: 20),
              ),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}
