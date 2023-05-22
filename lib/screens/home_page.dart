import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/patient_login.dart';
import 'package:flutter_application_1/screens/admin_login.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 199, 228, 206),
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topLeft,
      //         end: Alignment.bottomRight,
      //         colors: [
      //       Color.fromARGB(255, 130, 226, 159),
      //       Color.fromARGB(255, 123, 202, 127),
      //       Colors.white
      //     ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                 Container(
                    //alignment: Alignment.topCenter,
                    child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 30.0),
                            const Text(
                              "WELCOME",
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Text(
                              "What do you identify as?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 60.0,
                  ),
                  Image.asset(
                    "assets/images/patient.png",
                    width: 160,
                    height: 160,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const Patient_Login();
                      }));
                    },
                    child: const Text('Patient'),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 50.0,
                  ),
                  Image.asset(
                    "assets/images/surgeon.png",
                    width: 160,
                    height: 160,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AdminLogin();
                      }));
                    
                    },
                    child: const Text('Admin'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),)
    ;
  }
}
