import 'package:flutter/material.dart';
import 'package:mojtrsat/views/screens/home_screen.dart';
import 'package:mojtrsat/views/screens/main_screen.dart';
import 'package:mojtrsat/views/screens/registration_screen.dart';
import 'package:mojtrsat/views/screens/settings_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 31, 31, 50),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Dobrodošli u MojTrsat!',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      SizedBox(height: 50),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20, left: 100),
                          child: Text(
                            'Zaboravili ste lozinku?',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                      SizedBox(height: 60),
                      Text('ili',
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/google_icon.png',
                            width: 60,
                            height: 60,
                            colorBlendMode: BlendMode.multiply,
                          ),
                          SizedBox(
                            height: 90,
                            width: 200,
                          ),
                          Image.asset('assets/images/facebook_logo.jpg',
                              width: 60, height: 60),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              child: Text('Nemaš račun? Klikni ovdje'),
                              onPressed: () {
                                _navigateToRegistrationScreen(context);
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

  void _navigateToRegistrationScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegistrationScreen()));
  }
}
