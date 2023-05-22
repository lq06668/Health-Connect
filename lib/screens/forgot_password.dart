import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Forgot_Password extends StatefulWidget{
  const Forgot_Password({super.key});
  @override
  State<Forgot_Password> createState() => ForgotPassword();
}

class ForgotPassword extends State<Forgot_Password>{

  late final TextEditingController _usernameTextController = TextEditingController();

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
                "Forgot Password",
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
                      usernameField,
                      
                        SizedBox(
                          height: 10.0,
                        ),

       
                      ElevatedButton(
                          onPressed: () async {

                            try {
                              await FirebaseAuth.instance.sendPasswordResetEmail(email: _usernameTextController.text);
                              //print("Success");
                            } catch (e) {
                             //print("ew");
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  padding: const EdgeInsets.all(16),
                                  height: 75,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFC72C41),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  //child: Text(errorMessage.toString()),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    const Text("Error!", 
                                    style: TextStyle(fontSize: 15, color: Colors.white)),
                                    Text("Please enter Valid Email", 
                                    style: TextStyle(fontSize: 14, color: Colors.white)),
                                  ]
                                  )
                                  
                                )
                                
                                
                                
                                //Text(errorMessage.toString())
                              ),
                            );
                              // An error occurred while sending the password reset email.
                            }    
                           
                          },
                          child: Text("Send Password Reset Email")),
                    ],
                  ))
            ],
          ),
        ),
    ),
    );
  }

}