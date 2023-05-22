import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin_home.dart';

class EditHospital extends StatefulWidget {
  @override
  EditHospitalState createState() => EditHospitalState();
}

class EditHospitalState extends State<EditHospital> {
  // Initialize a list of hospitals to be populated by Firebase data
  List<String> _hospitalList = [];

  // Initialize a variable to keep track of the selected hospital
  String? _selectedHospital;

  // Initialize a variable to store the document ID of the selected hospital
  String? _selectedHospitalId;

  TextEditingController name = TextEditingController();
  TextEditingController add = TextEditingController();

  String? hospitalName = '';
  String? hospitalAddress = '';

  @override
  void initState() {
    super.initState();
    _getHospitals();
  }

  // Retrieve the list of hospitals from Firebase and update the _hospitalList variable
  Future<void> _getHospitals() async {
    final hospitals = await FirebaseFirestore.instance.collection('Hospital').get();
    setState(() {
      _hospitalList = List<String>.from(hospitals.docs
        .where((doc) => doc.data()['hospitalname'] != null) // Filter out docs without a "hospitalname" field
        .map((doc) => doc.data()['hospitalname'] as String) // Cast the "hospitalname" field to a String
      );
    });
  }

  // Find the document ID for the selected hospital
  Future<void> _getSelectedHospitalId() async {
    final selectedHospitalDoc = await FirebaseFirestore.instance.collection('Hospital').where('hospitalname', isEqualTo: _selectedHospital).get();
    setState(() {
      _selectedHospitalId = selectedHospitalDoc.docs[0].id;
    });
  }

  // Delete the selected hospital from Firebase
  // Delete the selected hospital from Firebase
 Future<void> _deleteHospital() async {
  final hospitalDoc = await FirebaseFirestore.instance.collection('Hospital')
    .where('hospitalname', isEqualTo: _selectedHospital)
    .get()
    .then((snapshot) => snapshot.docs.first);
  
  if (hospitalDoc.exists) {
    setState(() {
      name.text = hospitalDoc.data()['hospitalname'];
      add.text = hospitalDoc.data()['hospitaladdress'];
    });
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Hospital'),
      ),
      
      body: Center(
        child: Column(
          
          children: [
            DropdownButton<String>(
              value: _selectedHospital,
              hint: Text('Select a hospital'),
              onChanged: (value) {
                setState(() {
                  _selectedHospital = value;
                });
              },
              items: _hospitalList.map((hospital) {
                return DropdownMenuItem(
                  value: hospital,
                  child: Text(hospital),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            ElevatedButton(

              onPressed:
                _deleteHospital,
                //print(hospitalAddress);
                //print(hospitalName);
                
              child: Text('Show Information'),
            ),
            TextFormField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Hospital Name',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: add,
                decoration: InputDecoration(
                  labelText: 'Hospital Address',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(

              onPressed:() async
                {
                  final hospitalDoc = await FirebaseFirestore.instance.collection('Hospital')
                    .where('hospitalname', isEqualTo: _selectedHospital)
                    .get()
                    .then((snapshot) => snapshot.docs.first);

                  String docId = hospitalDoc.id; // ID of the document to be updated

// Define the new values for the hospitalname and hospitaladdress fields
                  String newHospitalName = name.text;
                  String newHospitalAddress = add.text;

                  // Create a DocumentReference object for the document to be updated
                  DocumentReference hospitalRef = FirebaseFirestore.instance.collection('Hospital').doc(docId);

                  // Call the update() method on the DocumentReference object to update the fields
                  hospitalRef.update({
                    'hospitalname': newHospitalName,
                    'hospitaladdress': newHospitalAddress,
                  }).then((value) => print('Document updated successfully.'))
                    .catchError((error) => print('Failed to update document: $error'));
                    
                    Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AdminHome();
                      }));
                    
                },
                //print(hospitalAddress);
                //print(hospitalName);
                
              child: Text('Confirm Edit'),
            ),
            

          ],
        ),
      ),
    );
  }
}