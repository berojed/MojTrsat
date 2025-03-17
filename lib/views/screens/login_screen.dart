import 'package:flutter/material.dart';
import 'package:mojtrsat/data/viewmodels/loginViewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  //controllers for getting email & password from  users input
  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final loginViewmodel= Provider.of<LoginViewmodel>(context);

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
                    Text('Dobrodošli u MojTrsat!', style: TextStyle(color: Colors.white, fontSize: 30),),
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
                              obscureText: true,
                    ),

                    if(loginViewmodel.isLoading=true) CircularProgressIndicator(),

                    if(loginViewmodel.errorMessage!=null)
                      Text(loginViewmodel.errorMessage!, style: TextStyle(color: Colors.red)),

                    ElevatedButton(onPressed: ()
                    {

                      loginViewmodel.login(emailController.text, passwordController.text);

                    } , 
                    child:Text('Login')),




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

                          mainAxisSize:MainAxisSize.min ,  
                          children: [
                            
                            
                            Image.asset('assets/images/google_icon.png',width:60 , height: 60, colorBlendMode: BlendMode.multiply,),
                            SizedBox(height: 90, width: 200,),

                            Image.asset('assets/images/facebook_logo.jpg',width:60 , height: 60),

                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                          
                              //onTap: {Navigator.push(context, MaterialPageRoute(builder: context => RegistrationScreen());},
                              child: Text('Kliknite ovdje za registraciju.', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),),
                            )
                          ],
                        )

                    
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
