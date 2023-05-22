// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/admin_home.dart';

// class DeleteDoctor extends StatefulWidget {
//   const DeleteDoctor({Key? key}) : super(key: key);

//   @override
//   _DeleteDoctorState createState() => _DeleteDoctorState();
// }

// class _DeleteDoctorState extends State<DeleteDoctor> {
//   String _selectedDoctor = 'Choose the Doctor';

//   void _deleteDoctor() {
//     if (_selectedDoctor == 'Choose the Doctor') {
//       return; // do nothing if no doctor is selected
//     }
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Are you sure?'),
//           content: Text('This action cannot be undone.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Delete'),
//               onPressed: () {
//                 // TODO: implement delete doctor functionality
//                 //Navigator.of(context).pop();
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return AdminHome();
//             }));
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text('Admin Home'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return AdminHome();
//             }));
//           },
//         ),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: <Widget>[
//               DropdownButtonFormField<String>(
//                 value: _selectedDoctor,
//                 onChanged: (String? value) {
//                   setState(() {
//                     _selectedDoctor = value!;
//                   });
//                 },
//                 items: <String>[
//                   'Choose the Doctor',
//                   'Doctor A',
//                   'Doctor B',
//                   'Doctor C',
//                 ].map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _deleteDoctor,
//                 child: Text('Delete'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.green,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteDoctor extends StatefulWidget {
  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<DeleteDoctor> {
  String? _selectedHospital;
  String? _selectedDoctor;
  List<String> _hospitals = [];
  List<String> _doctors = [];
  //List<String> _hospitalname = [];

  // Initialize Firebase and get a reference to the Hospital collection
  final _firestore = FirebaseFirestore.instance;
  final _hospitalRef = FirebaseFirestore.instance.collection('Hospital');

  @override
  void initState() {
    super.initState();
    // Call a function to get all the hospitals from the database
    _getHospitals();
  }

  // Function to get all the hospitals from the database
  void _getHospitals() async {
    await _hospitalRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot document) {
        setState(() {

          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    _hospitals.add(data['hospitalname']);
          

          //_hospitals.add(document.id);
        });
      });
    });
  }

  // Function to get all the doctors in a specific hospital from the database
  void _getDoctors(String hospitalName) async {
     final hospitalDoc = await FirebaseFirestore.instance.collection('Hospital')
                   .where('hospitalname', isEqualTo: hospitalName)
                    .get()
                    .then((snapshot) => snapshot.docs.first);
                  
    print(hospitalDoc.id);
    await _hospitalRef
        .doc(hospitalDoc.id)
        .collection('doctors')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot document) {
        setState(() {
          
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    _doctors.add(data['doctorName']);
          //_doctors.add(document.id);
        });
      });
    });
  }

  Future<String> getHospitalId(String hospitalName) async {
  final snapshot = await FirebaseFirestore.instance
    .collection('Hospital')
    .where('hospitalname', isEqualTo: hospitalName)
    .get();

  if (snapshot.docs.isEmpty) {
    throw Exception('No hospital found with name $hospitalName');
  }

  final hospitalDoc = snapshot.docs.first;
  final hospitalId = hospitalDoc.id;
  return hospitalId;
}

  // Function to delete a doctor from the database
  void _deleteDoctor(String hospitalName, String doctorName) async {
    print(hospitalName);
    print(doctorName);
    final hospitalId = await getHospitalId(hospitalName);

    final snapshot = await FirebaseFirestore.instance
    .collection('Hospital')
    .doc(hospitalId)
    .collection('doctors')
    .where('doctorName', isEqualTo: doctorName)
    .get();
    print(snapshot.docs.first.id);
    print(hospitalId);


    await _hospitalRef
        .doc(hospitalId)
        .collection('doctors')
        .doc(snapshot.docs.first.id)
        .delete();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Doctors'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Dropdown menu for hospitals
          DropdownButton<String>(
            value: _selectedHospital,
            hint: Text('Select a hospital'),
            onChanged: (String? newValue) {
              setState(() {
               
                _selectedHospital = newValue;
                _selectedDoctor = null;
                _doctors.clear();
                _getDoctors(newValue!); // Add '!' to assert that newValue is not null
              });
            },
            items: _hospitals.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),

          SizedBox(height: 20),
          // Dropdown menu for doctors
          DropdownButton<String>(
            value: _selectedDoctor,
            hint: Text('Select a doctor'),
            onChanged: (String? newValue) {
              setState(() {
                _selectedDoctor = newValue;
              });
            },
            items: _doctors.isNotEmpty
                ? _doctors.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()
                : [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Text('No doctors available'),
                    )
                  ],
          ),

          SizedBox(height: 20),
          // Delete button for deleting the selected doctor
          ElevatedButton(
              onPressed: () {
                if (_selectedDoctor != null) {
                  _deleteDoctor(_selectedHospital!, _selectedDoctor!); // Add '!' to assert that the values are not null
                  setState(() {
                    _doctors.remove(_selectedDoctor!); // Add '!' to assert that the value is not null
                    _selectedDoctor = null;
                  });
                }
              },
              child: Text('Delete Doctor'),
            ),

        ],
      ),
    ),
  );
}
}
             




