import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/hospital_search.dart';
import 'package:flutter_application_1/screens/sign_up2.dart';
import 'package:flutter_application_1/screens/admin_home.dart';

class AdminLogin extends StatelessWidget {
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final email = "admin@example.com";
    final password = "adminpassword";

    return Material(
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
          "Admin Login Page",
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
                TextFormField(
  controller: _usernameTextController, // add this line
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.person_outline),
    hintText: "Enter username",
    labelText: "USERNAME",
  ),
),
TextFormField(
  controller: _passwordTextController, // add this line
  obscureText: true,
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.lock_outline),
    hintText: "Enter Password",
    labelText: "PASSWORD"
  ),
),

                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      final enteredEmail =
                          _usernameTextController.text.trim();
                      final enteredPassword =
                          _passwordTextController.text.trim();

                      if (enteredEmail.trim() == email && enteredPassword.trim() == password) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AdminHome();
                        }));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Login Failed"),
                              content: Text(
                                  "Invalid email or password. Please try again."),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text("Login")),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ))
      ]),
    );
  }
}
