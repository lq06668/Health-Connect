import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/screens/edit_account.dart';
import 'package:flutter_application_1/screens/hospital_search.dart';
import 'package:flutter_application_1/screens/patient_login.dart';
class UserProfile extends StatefulWidget {
  final String uid;
  final String firstName;
  final String lastName;
  final String dateofbirth;
  final String gender ;
  final String marital;
  final String cnic;
  final String blood;
  final String height;
  final String weight;

  final bool asthma;
  final bool cancer;
  final bool cardiac;
  final bool diabetes;
  final bool tension;
  final bool epilepsy;
  final bool psych;

  final String tobacco;

  final String additional;
  final String medication;
  final String special;
  final String area;
  final String phone;

  UserProfile({required this.uid, required this.firstName, required this.lastName, required this.dateofbirth,
               required this.gender, required this.marital, required this.cnic, required this.blood, required this.height, 
               required this.weight,  required this.asthma,  required this.cancer,  required this.cardiac,  required this.diabetes,
               required this.tension,  required this.epilepsy,  required this.psych,  required this.tobacco,  required this.additional,
               required this.medication,  required this.special, required this.area, required this.phone
  });

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late User _user;
  //ate DocumentSnapshot _userData;

  String uid = '';

  String firstName = '';
  String lastName = '';
  String dob = '';
  String gender = '';
  String marital = '';
  String cnic = '';
  String blood = '';
  String height = '';
  String weight = '';

  bool asthma = false;
  bool cancer = false;
  bool cardiac = false;
  bool diabetes = false;
  bool tension = false;
  bool epilepsy = false;
  bool psych = false;

  String tobacco = '';

  String additional = '';
  String medication = '';
  String special = '';
  String area = '';
  String phone = '';

  TextEditingController _EnteredCnic = TextEditingController();


  @override
  void initState() {
    super.initState();
    //_user = FirebaseAuth.instance.currentUser!;
    _getUserData();
  }

  Future<void> _getUserData() async {
    
    uid = widget.uid;
    
    firstName = widget.firstName;
    lastName = widget.lastName;
    dob = widget.dateofbirth;
    gender = widget.gender;
    marital = widget.marital;
    cnic = widget.cnic;
    blood = widget.blood;
    height = widget.height;
    weight = widget.weight;

    asthma = widget.asthma;
    cancer = widget.cancer;
    cardiac = widget.cardiac;
    diabetes = widget.diabetes;
    tension = widget.tension;
    epilepsy = widget.epilepsy;
    psych = widget.psych;

    tobacco = widget.tobacco;

    additional = widget.additional;
    medication = widget.medication;
    special = widget.special;
    area = widget.area;
    phone = widget.phone;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                     Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Hospital_Search(userId: uid, username: firstName),
                      
                      ));
                  },
                ),
              ),

     
      body: 
           Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Row(
                    children: [
                      Container(
                              
                              child: Text(
                                '${firstName} ${lastName}',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                      // Text(
                      //   '${firstName} ${lastName}',
                      //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      // ),
                      SizedBox(width: 1), // add some spacing between the text widgets
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     children: [
                //       // add some spacing between the text widgets
                //       TextButton(
                //         onPressed: () {
                //           Navigator.push(context,
                //           MaterialPageRoute(builder: (context) {
                //         return Patient_Edit(uid: uid, firstName: firstName, lastName: lastName,
                //                              dateofbirth: dob, gender: gender, marital: marital,
                //                              cnic: cnic, blood: blood, height: height, weight: weight,
                //                              asthma: asthma,  cancer: cancer,  cardiac: cardiac,  
                //                              diabetes: diabetes, tension: tension,  epilepsy: epilepsy,  
                //                              psych: psych, tobacco: tobacco, additional: additional,
                //                              medication: medication,  special: special, area: area,
                //                              phone: phone);
                //       }));
                //         },
                //         child: Text(
                //           'Edit Account Information',
                //           style: TextStyle(fontSize: 15, decoration: TextDecoration.underline),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                    ],
                  ),
                ),
                //SizedBox(height: 10),

                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Personal Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'CNIC: ${cnic.substring(0,5)}-${cnic.substring(5,12)}-${cnic.substring(12)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Date of Birth: ${dob}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Gender: ${gender}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Phone: ${phone.substring(0, 4)}-${phone.substring(4)}',
                style: TextStyle(fontSize: 16),
                ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Area: ${area}',
                style: TextStyle(fontSize: 16),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Marital Status: ${marital}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Medical Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Blood Group: ${blood}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Height: ${height}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Weight: ${weight}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Medical Conditions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ),
                SizedBox(height: 10),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Asthma: ${asthma ? 'Yes' : 'No'}',
                style: TextStyle(fontSize: 16),
                ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Cancer: ${cancer ? 'Yes' : 'No'}',
                style: TextStyle(fontSize: 16),
                ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Cardiac: ${cardiac ? 'Yes' : 'No'}',
                style: TextStyle(fontSize: 16),
                ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Diabetes: ${diabetes ? 'Yes' : 'No'}',
                style: TextStyle(fontSize: 16),
                ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Epilepsy: ${epilepsy ? 'Yes' : 'No'}',
                style: TextStyle(fontSize: 16),
                ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Psychiatric: ${psych ? 'Yes' : 'No'}',
                style: TextStyle(fontSize: 16),
                ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'HyperTension: ${tension ? 'Yes' : 'No'}',
                style: TextStyle(fontSize: 16),
                ),
                ),
                SizedBox(height: 20),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Other Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ),
                
                SizedBox(height: 10),
                
                
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Ever consumed Tobacco? ${tobacco}',
                style: TextStyle(fontSize: 16),
                ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Any Special Needs? ${special}',
                style: TextStyle(fontSize: 16),
                ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                'Taking any Medication? ${medication}',
                style: TextStyle(fontSize: 16),
                ),
                ),

                SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    children: [
                      
                      // add some spacing between the text widgets
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Patient_Edit(uid: uid, firstName: firstName, lastName: lastName,
                                             dateofbirth: dob, gender: gender, marital: marital,
                                             cnic: cnic, blood: blood, height: height, weight: weight,
                                             asthma: asthma,  cancer: cancer,  cardiac: cardiac,  
                                             diabetes: diabetes, tension: tension,  epilepsy: epilepsy,  
                                             psych: psych, tobacco: tobacco, additional: additional,
                                             medication: medication,  special: special, area: area,
                                             phone: phone);
                      }));
                        },
                        child: Text(
                          'Edit Account Information',
                          style: TextStyle(fontSize: 15, ),
                        ),
                      ),

                    
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 130),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Enter your CNIC to confirm:'),
                          content: TextFormField(
                            controller: _EnteredCnic,
                            decoration: InputDecoration(
                              labelText: 'CNIC',
                              //hintText: 'Enter your CNIC to confirm:',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: (){
                                
                                if(_EnteredCnic.text == cnic){
                                    
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const Patient_Login();
                                }));}
                                else{
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                    return AlertDialog(title: Text('CNIC doesnt match'));});}},
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Delete Account?',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),

                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 130),
                    //   child: ElevatedButton(onPressed: () {}, child: Text(
                    //         'Delete Account?',
                    //         style: TextStyle(fontSize: 15, ),
                    //       ),),
                    // )
                
                ],
                ),
                );
                }
                }
