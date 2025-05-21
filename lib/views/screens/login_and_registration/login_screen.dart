import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mojtrsat/providers/auth_providers.dart';

class LoginScreen extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.watch(loginViewModelProvider.notifier);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
        child: Image.asset(
          'assets/images/kampus-rijeka38.jpg', 
          fit: BoxFit.cover,
        ),
      ),
          Positioned(
            top: 150,
            left: 100,
            right: 0,
            child: Column(
              children: const [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'MojTrsat',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 80.0),
                      child: Text(
                        'Za lakši život na Trsatu',
                        style: TextStyle(fontSize: 17, color: Colors.white, fontFamily: 'Poppins'),
                        softWrap: false,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Lower container with input fields and buttons
          Positioned.fill(
            top: size.height * 0.35,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              color: const Color(0xFF1C1C1E),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 25),

                  // Password
                  _buildInputField(
                    controller: passwordController,
                    hint: 'Lozinka',
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),

                  // Log In button
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await loginViewModel.login(
                          emailController.text,
                          passwordController.text,
                        );
                        result.fold(
                          (failure) =>
                              ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(failure.message)),
                          ),
                          (success) => context.go('/session'),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: const Text('Prijava',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Divider
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.white24)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Ili',
                            style: TextStyle(color: Colors.white60)),
                      ),
                      Expanded(child: Divider(color: Colors.white24)),
                    ],
                  ),
                  const SizedBox(height: 35),

                  // Social login icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(icon: Icons.apple, onTap: () {}),
                      const SizedBox(width: 32),
                      _buildSocialIcon(
                        imageAsset: 'assets/images/google_icon.png',
                        onTap: () async {
                          try {
                            
                            final alreadySignedIn =
                                await loginViewModel.isGoogleSignedIn();
                            if (alreadySignedIn) {
                              await loginViewModel
                                  .signOutFromGoogle(); 
                            }

                            await loginViewModel.signUpWithGoogle();
                            final userExists =
                                await loginViewModel.userExists();

                            // Checking if the widget is still "alive" before navigating
                                if (!context.mounted) return;

                            if (userExists) {
                              context.push('/session');
                            } else {
                              context.push('/registration/uniri_credentials');
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Google login failed: $e')),
                            );
                          }
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Sign Up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Nemate račun?",
                          style: TextStyle(color: Colors.white70)),
                      TextButton(
                        onPressed: () => context.push('/registration'),
                        child: const Text(
                          'Registracija',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Email field that overlaps the top container
          Positioned(
            top: size.height * 0.35 - 28,
            left: 24,
            right: 24,
            child: _buildInputField(
              controller: emailController,
              hint: 'Email',
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
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(32),
      color: Colors.transparent,
      child: TextField(
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  static Widget _buildSocialIcon({
    IconData? icon,
    String? imageAsset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF2C2C2E),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: Colors.white, size: 28)
              : Image.asset(imageAsset!, width: 28, height: 28),
        ),
      ),
    );
  }
}
