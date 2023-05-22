import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/doctors.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/screens/doctor_profile.dart';

class Doctor_Search extends StatefulWidget{
  final String hospitalName;
  final String userId;
  final String username;

  const Doctor_Search({required this.hospitalName, required this.userId, required this.username});
  @override
  State<Doctor_Search> createState() => _DoctorSearchState();
}

class _DoctorSearchState extends State<Doctor_Search> {
  late String hospitalName;
  late String userId;
  late String username;
  Stream<QuerySnapshot>? _stream;

  @override
  void initState() {
    super.initState();
    hospitalName = widget.hospitalName;
    userId = widget.userId;
    username = widget.username;

    FirebaseFirestore.instance
        .collection('Hospital')
        .where('hospitalname', isEqualTo: hospitalName)
        .get()
        .then((QuerySnapshot snapshot) {
      final docs = snapshot.docs;
      final hospitalDoc = docs.isNotEmpty ? docs.first : null;
      final hospitalId = hospitalDoc?.id;
      setState(() {
        _stream = FirebaseFirestore.instance
            .collection('Hospital')
            .doc(hospitalId)
            .collection('doctors')
            .snapshots();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
        ),
        title: Text('Doctors in $hospitalName'),
      ),
      body: _stream == null
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
              stream: _stream!,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data?.docs;

                if (docs == null || docs.isEmpty) {
                  return Center(
                      child: Text('No doctors found in $hospitalName'));
                }

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final doctorDoc = docs[index];
                    final doctorData =
                        doctorDoc.data() as Map<String, dynamic>;

                    

                    final doctor = Doctors(
                      name: doctorData['doctorName'] as String,
                      specialization: doctorData['specialization'] as String,
                      education: doctorData['education'] as String,
                      about: doctorData['about'] as String,
                      experience: doctorData['experience'] as String,
                      bad: doctorData['reviews']['bad'] as int,
                      good: doctorData['reviews']['good'] as int,
                      medium: doctorData['reviews']['medium'] as int,
                      
                    );

                    return ListTile(
                      title: Text(doctor.name),
                      subtitle: Text(doctor.specialization),
                      onTap: () {
                        //print(doctor.education);
                        
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorProfilePage(
                                name: doctor.name,
                                specialization: doctor.specialization,
                                about: doctor.about,
                                education: doctor.education,
                                experience: doctor.experience,
                                bad: doctor.bad,
                                good: doctor.good,
                                medium: doctor.medium,
                              ),
                            ),
                          );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
