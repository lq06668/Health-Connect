import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin_home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/auth/auth_hospital.dart';

class AddHospital extends StatefulWidget {
  const AddHospital({Key? key}) : super(key: key);

  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  void _submitForm() async {
      print("added");
      final name = _nameController.text;
      final address = _addressController.text;
      AuthService3 authService = AuthService3();
      String? errorMessage = await authService.hospitalAdd(name, address);
      
      if (errorMessage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hospital added successfully')),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AdminHome();
        }));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );

      }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Admin Home'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AdminHome();
            }));
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Hospital Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hospital name cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Hospital Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hospital address cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () async {
                   final name = _nameController.text;
                  final address = _addressController.text;
                  AuthService3 authService = AuthService3();
                    String? errorMessage = await authService.hospitalAdd(name, address);

                   if (errorMessage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hospital added successfully')),
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return AdminHome();
                      }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );

      }
                    //_submitForm;

            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return AdminHome();
            // }));
          },
                  child: Text('Add Hospital'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
