import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/add_hospital.dart';
import 'package:flutter_application_1/screens/delete_hospital.dart';
import 'package:flutter_application_1/screens/add_doctor.dart';
import 'package:flutter_application_1/screens/delete_doctor.dart';
import 'package:flutter_application_1/screens/edit_hospital.dart';

class AdminHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.green,
    title: Text('Admin Home'),
    leading: IconButton(
      icon: Icon(Icons.logout),
     onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return MyHomePage();
                  }));
                },
    ),
  ),
  body: Container(
    color: Colors.white,
    child: Center(
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60.0,
              ),
              Image.asset(
                "assets/images/hospital_admin.png",
                width: 160,
                height: 160,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  ),


                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return AddHospital();
                  }));
                },
                child: Text('Add Hospital'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
              style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  ),

                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return DeleteHospital();
                  }));
                },
                child: Text('Delete Hospital'),
              ),
               SizedBox(height: 10),
              ElevatedButton(
              style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  ),

                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return EditHospital();
                  }));
                },
                child: Text('Edit Hospital'),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Image.asset(
                "assets/images/doctor_admin.png",
                width: 160,
                height: 160,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  ),

                onPressed: () {
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) {
                     return AddDoctor();
                   }));
                },
                child: Text('Add Doctor'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  ),

                onPressed: () {
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) {
                     return DeleteDoctor();
                   }));
                },
                child: Text('Delete Doctor'),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);

  }
}