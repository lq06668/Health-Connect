
import 'package:flutter/material.dart';

import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/hospital_search.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/screens/sign_up2.dart';
import 'package:flutter_application_1/auth/auth_email.dart';
import 'package:flutter_application_1/screens/forgot_password.dart';

class Patient_Login extends StatefulWidget{
  const Patient_Login({super.key});
  @override
  State<Patient_Login> createState() => PatientLogin();
}

class PatientLogin extends State<Patient_Login>{

 // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  final FirebaseAuth auth = FirebaseAuth.instance;
  late final TextEditingController _passwordTextController; //= TextEditingController();
  late final TextEditingController _usernameTextController; //= TextEditingController();
  
  @override
  void initState(){
    _passwordTextController = TextEditingController();
    _usernameTextController = TextEditingController();
   // _FnameTextController = TextEditingController();
   // _LnameTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _passwordTextController.dispose();
    _usernameTextController.dispose();
   // _FnameTextController.dispose();
    //_LnameTextController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    final usernameField = TextFormField(
                  controller: _usernameTextController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: "Enter Email Address",
                    labelText: "Email",
                  ),
                );

    final passwordField = TextFormField(
                  controller: _passwordTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      hintText: "Enter Password",
                      labelText: "PASSWORD"),
                );

    return Scaffold(
     
     body: Material(
      color: Colors.white,
      child: Column(children: [
        AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyHomePage();
              }));
            },
          ),
        ),
        Image.asset(
          "assets/images/undraw_medical_care_movn.png",
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Patients Login Page",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                usernameField,
                passwordField,

                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    onPressed: () async {

                      final email = _usernameTextController.text;
                      final password = _passwordTextController.text;

                      EmailAuthService emailauthService = EmailAuthService();
                      String? errorMessage = await emailauthService.LoginUserWithEmailAndPassword(email, password);
                      print(errorMessage);

                     

                      if (errorMessage == 'Yay'){

                        UserCredential userCredential = await auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        User? user = userCredential.user;
                        String userId = user?.uid ?? '';

                        final userData = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId.toString())
                            .get();

                        final data = userData.data() as Map<String, dynamic>;
                        String user_Name = data['firstName'];

            

                        
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Hospital_Search(userId: userId, username: user_Name),
                      
                      ));
                        

                
                         
                      }
                      else{
  
                        ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  padding: const EdgeInsets.all(16),
                                  height: 70,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFC72C41),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  //child: Text(errorMessage.toString()),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    
                                    Text(errorMessage.toString() , 
                                    style: TextStyle(fontSize: 14, color: Colors.white)),
                                  ]
                                  )
                                  
                                )
                                
                                
                                
                                //Text(errorMessage.toString())
                              ),
                            );
                      }
                      


                     
                    },
                    child: Text("Login")),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Patient_SignUp();
                        }));
                        // Navigate to Signup screen
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          fontSize: 16.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Forgot_Password();
                        }));
                        // Navigate to Signup screen
                      },
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 16.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ))
      ]),
    ));
  }
  
}