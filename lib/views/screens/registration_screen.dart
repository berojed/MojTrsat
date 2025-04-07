import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mojtrsat/viewmodels/providers.dart';
import 'package:mojtrsat/viewmodels/registrationViewmodel.dart';

class RegistrationScreen extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationViewModel =
        ref.watch(registrationViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Color(0x00121212),
      body: Stack(
        children: [
          Image.asset('assets/images/kampus-rijeka38.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          Container(
            color: Color.fromARGB(176, 102, 27, 97),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: EdgeInsets.only(top: 80, left: 80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('MojTrsat',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    Padding(
                        padding: EdgeInsets.only(left: 100),
                        child: Text('Za lakši život na Trsatu',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black))),
                  ],
                )),
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 31, 31, 50),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 50),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(height: 60),
                    ElevatedButton(
                        onPressed: () async {
                          final email = emailController.text;
                          final password = passwordController.text;
                          bool success = await registrationViewModel.signup(
                              email, password);

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Uspješna registracija!')));

                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.pushReplacementNamed(context, '/home');
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Registracija nije uspjela.')));
                          }
                        },
                        child: Text('Registracija')),
                    Text('ili',
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              final isSignedIn = await registrationViewModel
                                  .isGoogleSignedIn();
                              if (!isSignedIn) {
                                await registrationViewModel.signUpWithGoogle();
                              }
                              context.go('/home');
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
                        SizedBox(
                          height: 60,
                          width: 60,
                        ),
                        Image.asset(
                          'assets/images/facebook_logo.png',
                          width: 60,
                          height: 60,
                          colorBlendMode: BlendMode.multiply,
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
