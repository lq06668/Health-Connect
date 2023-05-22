import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import  'package:flutter_application_1/screens/patient_login.dart';
class verify_Email extends StatefulWidget{
  final String email;
  final String password;
  final User user;
  const verify_Email({required this.email, required this.password, required this.user});

  @override
  State<verify_Email> createState() => verifyEmail();
}

class verifyEmail extends State<verify_Email>{

  late final TextEditingController _usernameTextController = TextEditingController();

  String email = '';
  String password = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  late User user;

  @override
  void initState() {
    super.initState();
    _getUserData();

    auth.authStateChanges().listen((User? user) {
    if (user != null && user.emailVerified) {
      // Navigate to the verified user screen
      print('hi');
      
      Navigator.pushReplacementNamed(context, '/Patient_Login');
    }
  });
  }
  

  Future<void> _getUserData() async {
    password = widget.password.toString();
    email = widget.email.toString();
    user = widget.user;
    
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Verify Email",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    // Column(
                    children: [
                      Text(
                        "Please check your email for Verification Link :D",
                        style: TextStyle(
                          fontSize: 15,
                          
                        ),
                      ),
                            
                      
                        SizedBox(
                          height: 10.0,
                        ),

       
                      ElevatedButton(
                          onPressed: () async {

                             

                            try {
                                
                                await user.sendEmailVerification();
                                
                              } on FirebaseAuthException catch (e) {
                                 print("$e");
                              } catch (e) {
                                print("??");
                              }

                            
                                
                               
                           
                          },
                          child: Text("Resend Email")),
                    ],
                  ))
            ],
          ),
        ),
    ),
    );
  }

}