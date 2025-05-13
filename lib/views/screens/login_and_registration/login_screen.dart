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

    return Scaffold(
      backgroundColor: const Color(0x00121212),
      body: Stack(
        children: [
          Image.asset('assets/images/kampus-rijeka38.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          Container(
            color: const Color.fromARGB(176, 102, 27, 97),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: const EdgeInsets.only(top: 80, left: 80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('MojTrsat',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    const Padding(
                        padding: EdgeInsets.only(left: 100),
                        child: Text('Za lakši život na Trsatu',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black))),
                  ],
                )),
          ),
          Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 31, 31, 50),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Dobrodošli u MojTrsat!',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      const SizedBox(height: 50),
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                      ),
                      if (loginViewModel.errorMessage != null)
                        Text(loginViewModel.errorMessage!,
                            style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () async {
                            final email = emailController.text;
                            final password = passwordController.text;

                            final result =
                                await loginViewModel.login(email, password);

                            // Handle the login result
                            result.fold(
                                (failure) => ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(failure.message))),
                                (success) => context.go('/session'));
                          },
                          
                          child: const Text('Login')),
                      Padding(
                          padding: const EdgeInsets.only(top: 20, left: 180),
                          child: GestureDetector(
                            child: Text('Zaboravljena lozinka?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            onTap: () {
                              context.push('/reset_password');
                            },
                          )),
                      const SizedBox(height: 30),
                      const Text('ili',
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              try {
                                await loginViewModel.signOutFromGoogle();

                                await loginViewModel.signUpWithGoogle();

                                context.go('/session');
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Error during Google sign-up: $e')),
                                );
                              }
                            },
                            child: Image.asset(
                              'assets/images/google_icon.png',
                              width: 60,
                              height: 60,
                              colorBlendMode: BlendMode.multiply,
                            ),
                          ),
                          const SizedBox(
                            height: 90,
                            width: 130,
                          ),
                          Image.asset(
                            'assets/images/facebook_logo.png',
                            width: 60,
                            height: 60,
                            colorBlendMode: BlendMode.multiply,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              child: const Text('Nemaš račun? Klikni ovdje'),
                              onPressed: () {
                                context.push(
                                    '/registration'); // Navigacija na registraciju
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
