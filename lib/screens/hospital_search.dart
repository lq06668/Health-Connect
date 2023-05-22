

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/hospitals.dart';

import 'package:flutter_application_1/screens/patient_login.dart';
import 'package:flutter_application_1/widgets/hospital_widget.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/screens/user_profile.dart';

class Hospital_Search extends StatefulWidget{
  final String userId;
  final String username;
  const Hospital_Search({required this.userId, required this.username});
  @override
  State<Hospital_Search> createState() => HospitalSearch();
}

class HospitalSearch extends State<Hospital_Search>{

  //
  //const Hospital_Search({required this.userId});
  String userName = '';
  String uid = '';

  @override
  void initState() {
    super.initState();
    //_getUserData();
  }
  

  Future<void> _getUserData() async {
    userName = widget.username.toString();
    uid = widget.userId.toString();
  }
  
 
  @override
  Widget build(BuildContext context) {
    _getUserData();
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                
                await FirebaseAuth.instance.signOut();

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Patient_Login();
                }));
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Image.asset(
            "assets/images/user.png",
            width: 60,
            height: 60,
          ),
          // "Hello user" text
          Padding(
            
            padding: const EdgeInsets.all(16.0),
            child: Text(
                    'Hello $userName',
                    style: const TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                
          ),

          // Search bar
          const Padding(
            
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Search hospitals',
              ),
            ),
          ),

          // Hospital list
         
         Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Hospital').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print ('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                final docs = snapshot.data?.docs;

                return ListView.builder(
                  itemCount: docs?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final hospitalDoc = docs![index];
                    final hospitalData = hospitalDoc.data() as Map<String, dynamic>;
                    final hospitalItem = HospitalItem(
                      name: hospitalData['hospitalname'] as String,
                      location: hospitalData['hospitaladdress'] as String,
                    );

                    return HospitalWidget(item: hospitalItem, userid: uid, username: userName);
                  },
                );
              },
            ),
          ),
        ),




          Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    ElevatedButton(
                      onPressed: () async{
                        late User _user;
                        late DocumentSnapshot _userData;

                        _userData = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .get();
                        setState(() {});

                        String firstname = _userData['firstName'];
                        String lastname = _userData['lastName'];
                        String dob = _userData['dateofbirth'];
                        String _gender = _userData['gender'];
                        String _marital = _userData['marital'];
                        String _cnic = _userData['cnic'].toString();
                        String _blood = _userData['bloodgroup'];
                        String _height = _userData['height'].toString();
                        String _weight = _userData['weight'].toString();
                        String _area = _userData['area'].toString();

                        bool _asthma = _userData['asthma'];
                        bool _cancer = _userData['cancer'];
                        bool _cardiac = _userData['cardiac'];
                        bool _diabetes = _userData['diabetes'];
                        bool _tension = _userData['tension'];
                        bool _epilepsy = _userData['epilepsy'];
                        bool _psych = _userData['psychiatric'];

                        String _tobacco = _userData['tobacco'].toString();

                        String _additional = _userData['additional Information'];
                        String _medication = _userData['medicine'];
                        String _special = _userData['special needs'];
                        String _phone = '0' + _userData['phone'].toString();


                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return UserProfile(uid: uid, firstName: firstname, lastName: lastname,
                                             dateofbirth: dob, gender: _gender, marital: _marital,
                                             cnic: _cnic, blood: _blood, height: _height, weight: _weight,
                                             asthma: _asthma,  cancer: _cancer,  cardiac: _cardiac,  
                                             diabetes: _diabetes, tension: _tension,  epilepsy: _epilepsy,  
                                             psych: _psych, tobacco: _tobacco, additional: _additional,
                                             medication: _medication,  special: _special, area: _area,
                                             phone: _phone
                          );
                        }));
                        
                        }
                        // Navigate to Signup screen
                      ,
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 17.0,
                          //decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
