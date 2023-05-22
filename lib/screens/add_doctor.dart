import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/screens/admin_home.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/auth/auth_doctor.dart';
class AddDoctor extends StatefulWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  _AddDoctorState createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final _formKey = GlobalKey<FormState>();
  String _selectedHospital = 'Choose Hospital for Doctor';

  TextEditingController _doctorName = TextEditingController();
  TextEditingController _education = TextEditingController();
  TextEditingController _experience = TextEditingController();
  TextEditingController _textbox1 = TextEditingController();

  int _selectedAge = 0;
  int _selectedExperience = 0;
  String _selectedSpecialization = 'Choose Specialization';
  
  List<String> _hospitalList = [];

  final List<String> _specializations = [  'Cardiology',   'Dermatology',    'Endocrinology',    'Gastroenterology',    'Hematology',    'Infectious Disease',    'Neurology',    'Oncology',    'Pediatrics',    'Psychiatry',    'Radiology',    'Rheumatology',  ];
  
  String specialise = 'Cardiology';
  final specialoptions = [  'Cardiology',   'Dermatology',    'Endocrinology',    'Gastroenterology',    'Hematology',    'Infectious Disease',    'Neurology',    'Oncology',    'Pediatrics',    'Psychiatry',    'Radiology',    'Rheumatology',  ];
  Future<void> _addDoctor () async {
    
    
    final hospitalDoc = await FirebaseFirestore.instance.collection('Hospital')
      .where('hospitalname', isEqualTo: _selectedHospital)
      .get()
      .then((snapshot) => snapshot.docs.first);

    print(hospitalDoc.id);
    //sAuthService4 authService = AuthService4();
    //String? errorMessage = await authService.DoctorAdd(name, address);

    return; // do nothing if no hospital is selected
  }
    
 

  @override
  void initState() {
    super.initState();
    // fetch hospital names from Firestore and update _hospitalList
    FirebaseFirestore.instance
        .collection('Hospital')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                _hospitalList.add(doc["hospitalname"]);
              })
            });
  }

  

  @override
  Widget build(BuildContext context) {

    final genderField = DropdownButtonFormField(
                      value: specialise,
                      decoration: InputDecoration(
                        labelText: "Specialisation",
                      ),
                      items: specialoptions.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (selectedGender) {
                        setState(() {
                          specialise = selectedGender!;
                        });
                      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Add Doctor'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return AdminHome();
              }),
            );
          },
        ),
      ),
      
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField(
                value: _selectedHospital,
                onChanged: (value) {
                  setState(() {
                    _selectedHospital = value.toString();
                  });
                },
                items: [
                  'Choose Hospital for Doctor',
                  ..._hospitalList,
                ].map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _doctorName,
                decoration: InputDecoration(
                  labelText: 'Doctor Name',
                ),
                
              ),
              SizedBox(height: 16.0),
               TextFormField(
                controller: _education,
                decoration: InputDecoration(
                  labelText: 'Education',
                ),
              ),
              SizedBox(height: 16.0),

              TextFormField(
                controller: _experience,
                inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                decoration: InputDecoration(
                  labelText: 'Experience (years)',
                ),
                
              ),

              SizedBox(height: 16.0),
              genderField,
                 SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "About",
                        style: TextStyle(
                          fontSize: 16,
                         
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                Container(
                    height: 150,
                    // child: SingleChildScrollView(
                    child: TextField(
                      maxLines: 4,
                      controller: _textbox1,
                      decoration: InputDecoration(
                        hintText: "Enter text here",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

           

              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () async {_addDoctor;
                final hospitalDoc = await FirebaseFirestore.instance.collection('Hospital')
      .where('hospitalname', isEqualTo: _selectedHospital)
      .get()
      .then((snapshot) => snapshot.docs.first);

      
      final hospital = _selectedHospital;
      final doctorname = _doctorName.text;
      final education = _education.text;
      final experience = _experience.text;
      final specialisee = specialise;
      final about = _textbox1.text;

      AuthService4 authService = AuthService4();
      String? errorMessage = await authService.DoctorAdd(hospitalDoc.id, doctorname, education, experience, specialisee, about);
      // Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) {
      //           return AdminHome();
      //         }),
      //       );
      if(_doctorName.text == ""){
        showDialog(
              context: context,
              builder: (BuildContext context){
              return AlertDialog(title: Text('Doctor Name cant be empty!'));});}
      else if(_education.text == ""){
        showDialog(
              context: context,
              builder: (BuildContext context){
              return AlertDialog(title: Text('Education cant be empty!'));});}
      else if(_experience.text == ""){
        showDialog(
              context: context,
              builder: (BuildContext context){
              return AlertDialog(title: Text('Experience cant be empty!'));});}
      else if(_textbox1.text == ""){
        showDialog(
              context: context,
              builder: (BuildContext context){
              return AlertDialog(title: Text('About cant be empty!'));});}
      else{
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return AdminHome();
              }),
            );
      }

    },
                child: Text('Add Doctor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







//   'Dermatology',    'Endocrinology',    'Gastroenterology',    'Hematology',    'Infectious Disease',    'Neurology',    'Oncology',    'Pediatrics',    'Psychiatry',    'Radiology',    'Rheumatology',  