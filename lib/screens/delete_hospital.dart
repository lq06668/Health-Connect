// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/admin_home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DeleteHospital extends StatefulWidget {
//   const DeleteHospital({Key? key}) : super(key: key);

//   @override
//   _DeleteHospitalState createState() => _DeleteHospitalState();
// }

// class _DeleteHospitalState extends State<DeleteHospital> {
//   String _selectedHospital = "";
  

//   void _deleteHospital() {
//     //if (_selectedHospital == 'Choose the hospital') {
//     // / return; // do nothing if no hospital is selected
//     //}
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
//                 // TODO: implement delete hospital functionality
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
//               // DropdownButtonFormField<String>(
//               //   value: _selectedHospital,
//               //   onChanged: (String? value) {
//               //     setState(() {
//               //       _selectedHospital = value!;
//               //     });
//               //   },
//               //   items: <String>[
//               //     'Choose the hospital',
//               //     'Hospital A',
//               //     'Hospital B',
//               //     'Hospital C',
//               //   ].map<DropdownMenuItem<String>>((String value) {
//               //     return DropdownMenuItem<String>(
//               //       value: value,
//               //       child: Text(value),
//               //     );
//               //   }).toList(),
//               // ),

// StreamBuilder<QuerySnapshot>(
//   stream: FirebaseFirestore.instance.collection('Hospital').snapshots(),
//   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     }

//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const CircularProgressIndicator();
//     }

//     return DropdownButtonFormField<String>(
//         value: _selectedHospital,
//         onChanged: (String? value) {
//           setState(() {
//             _selectedHospital = value!;
//           });
//         },
//         hint: Text('Select a hospital'),
//         items: snapshot.data?.docs.map<DropdownMenuItem<String>>((document) {
//           final hospitalData = document.data() as Map<String, dynamic>;
//           return DropdownMenuItem<String>(
//             value: hospitalData['hospitalname'] as String,
//             child: Text(hospitalData['hospitalname'] as String),
//           );
//         }).toList(),
//       );

//   },
// ),



              


//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _deleteHospital,
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteHospital extends StatefulWidget {
  @override
  _DeleteHospitalState createState() => _DeleteHospitalState();
}

class _DeleteHospitalState extends State<DeleteHospital> {
  // Initialize a list of hospitals to be populated by Firebase data
  List<String> _hospitalList = [];

  // Initialize a variable to keep track of the selected hospital
  String? _selectedHospital;

  // Initialize a variable to store the document ID of the selected hospital
  String? _selectedHospitalId;

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
      await hospitalDoc.reference.delete();
      setState(() {
        _selectedHospital = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hospital deleted')));
      await _getHospitals();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete hospital')));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Hospital'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedHospital == null ? null : _deleteHospital,
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}

