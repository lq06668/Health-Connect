import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/auth/auth_services_edit.dart';
import 'package:flutter_application_1/screens/patient_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/verify_email.dart';
import 'package:flutter_application_1/screens/user_profile.dart';

class Patient_Edit extends StatefulWidget {

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

  Patient_Edit({required this.uid, required this.firstName, required this.lastName, required this.dateofbirth,
               required this.gender, required this.marital, required this.cnic, required this.blood, required this.height, 
               required this.weight,  required this.asthma,  required this.cancer,  required this.cardiac,  required this.diabetes,
               required this.tension,  required this.epilepsy,  required this.psych,  required this.tobacco,  required this.additional,
               required this.medication,  required this.special, required this.area, required this.phone
  });


  @override
  _Patient_EditState createState() => _Patient_EditState();
}

class _Patient_EditState extends State<Patient_Edit> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;
  

  //late final TextEditingController _FnameTextController;
  //late final TextEditingController _LnameTextController;
  //TextEditingController _email = TextEditingController();
  //TextEditingController _emailpartone = TextEditingController();
  //TextEditingController _emailparttwo = TextEditingController();
  TextEditingController _FnameTextController = TextEditingController();
  TextEditingController _LnameTextController = TextEditingController();

  //TextEditingController _passTextController = TextEditingController();
  TextEditingController _confirmpassTextController = TextEditingController();
  //TextEditingController _cnicpartone = TextEditingController();
  //TextEditingController _cnicparttwo = TextEditingController();
  //TextEditingController _cnicpartthree = TextEditingController();
  TextEditingController _cnic = TextEditingController();

  TextEditingController _phonenumb = TextEditingController();
  //TextEditingController _area = TextEditingController();

  TextEditingController _weight = TextEditingController();
  TextEditingController _height = TextEditingController();

  TextEditingController _textbox1 = TextEditingController();
  TextEditingController _textbox2 = TextEditingController();
  TextEditingController _textbox3 = TextEditingController();
  
  String _bloodgroup = '';
  String _gender = '';
  String _tobacco = '';
  String _Area = '';
  String _marital = '';

  bool _asthma = false;
  bool _cancer = false;
  bool _cardiac = false;
  bool _diabetes = false;
  bool _hypertension = false;
  bool _psychiatric = false;
  bool _epilepsy = false;
  DateTime _selectedDate = DateTime.now();
  String uid = '';
 

  @override
  void initState(){
    _email = TextEditingController();
    _password = TextEditingController();
    _getUserData();
   // _FnameTextController = TextEditingController();
   // _LnameTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _email.dispose();
    _password.dispose();
   // _FnameTextController.dispose();
    //_LnameTextController.dispose();
    super.dispose();
  }

  Future<void> _getUserData() async {

    uid = widget.uid;
   

    _FnameTextController = TextEditingController(text: widget.firstName);
    _LnameTextController = TextEditingController(text: widget.lastName);
    _cnic = TextEditingController(text: widget.cnic);
    _bloodgroup = widget.blood;
    _gender = widget.gender;

    //uid = widget.uid;
    
    //_selectedDate = DateTime.parse(widget.dateofbirth);
    
    _selectedDate = new DateFormat('dd/MM/yyyy').parse(widget.dateofbirth);
   
    _marital = widget.marital;
   
    
    _height = TextEditingController(text: widget.height);
    _weight = TextEditingController(text: widget.weight);

    _asthma = widget.asthma;
    _cancer = widget.cancer;
    _cardiac = widget.cardiac;
    _diabetes = widget.diabetes;
    _hypertension = widget.tension;
    _epilepsy = widget.epilepsy;
    _psychiatric = widget.psych;

    _tobacco = widget.tobacco;

    _textbox3 = TextEditingController(text: widget.additional);
    _textbox1 = TextEditingController(text: widget.medication);
    _textbox2 = TextEditingController(text: widget.special);

    _Area = widget.area;

    _phonenumb = TextEditingController(text: widget.phone);

  }

  //String _gender = 'Male';
  final genderOptions = ['Male', 'Female', 'Other'];
  
  
  //String _Area = "DHA Phase 6";
  final areaOptions = ["DHA Phase 6", "DHA Phase 5", "DHA Phase 1", "DHA Phase 2"];

  //String _bloodgroup = 'A+';
  final bloodgroupOptions = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  


  //String _tobacco = 'No';
  final TobaccoAnswers = ['Yes', 'No'];

  //String _marital = 'Single';
  final MaritalAnswers = ['Single', 'Married', 'Divorced'];



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final FirstNameField = TextFormField(
      controller: _FnameTextController,
      validator: (value){
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty){
          return("First Name cannot be Empty");
        }
        if (!regex.hasMatch(value)){
          return ("Enter Valid name(Min. 3 Characters)");
        }
      },
      onSaved: (value){
        _FnameTextController.text = value!;
      },
      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                      ],
      decoration: InputDecoration(
                        labelText: "First Name ",
                          
                          suffix: Text(
                            "*",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                            ),
                          ),
                        
                      ),
    );
    
    final LastNameField = TextFormField(
      controller: _LnameTextController,
      validator: (value){
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty){
          return("Last Name cannot be Empty");
        }
        if (!regex.hasMatch(value)){
          return ("Enter Valid name(Min. 3 Characters)");
        }
      },
      onSaved: (value){
        _LnameTextController.text = value!;
      },
      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                      ],
      decoration: InputDecoration(
                        labelText: "Last Name ",
                          
                          suffix: Text(
                            "*",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                            ),
                          ),
                      ),
    );
    
    

    
    
    
    final genderField = DropdownButtonFormField(
                      value: _gender,
                      decoration: InputDecoration(
                        labelText: "Gender",
                      ),
                      items: genderOptions.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (selectedGender) {
                        setState(() {
                          _gender = selectedGender!;
                        });
                      },
    );

    final phoneField = TextFormField(
      controller: _phonenumb,

      onSaved: (value){
        _cnic.text = value!;
      },
      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
      
      decoration: InputDecoration(
                        labelText: "Phone Number",
                         suffix: Text(
                            "*",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                            ),
                          ),
                      ),
    );

    final dateField = Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null && picked != _selectedDate) {
                                setState(() {
                                  _selectedDate = picked;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Date of Birth",
                                            suffix: Text(
                                      "*",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                ),
                                controller: TextEditingController(
                                  text: DateFormat('dd/MM/yyyy')
                                      .format(_selectedDate),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );

      final areaField = DropdownButtonFormField(
                      value: _Area,
                      decoration: InputDecoration(
                        labelText: "Area",
                      ),
                      items: areaOptions.map((Area) {
                        return DropdownMenuItem(
                          value: Area,
                          child: Text(Area),
                        );
                      }).toList(),
                      onChanged: (selectedGender) {
                        setState(() {
                          _Area = selectedGender!;
                        });
                      },
    );

    final bloodgroupField = DropdownButtonFormField(
                    value: _bloodgroup,
                    decoration: InputDecoration(
                      labelText: "Blood Group",
                    ),
                    items: bloodgroupOptions.map((BloodGroup) {
                      return DropdownMenuItem(
                        value: BloodGroup,
                        child: Text(BloodGroup),
                      );
                    }).toList(),
                    onChanged: (selectedBloodGroup) {
                      setState(() {
                        _bloodgroup = selectedBloodGroup!;
                      });
                    },
                  );

    final asthmaField = Row(
                    children: [
                      Checkbox(
                        value: _asthma,
                        onChanged: (bool? value) {
                          setState(() {
                            _asthma = value!;
                          });
                        },
                      ),
                      Text("Asthma"),
                    ],
                  );
    final cancerField = Row(
                    children: [
                      Checkbox(
                        value: _cancer,
                        onChanged: (bool? value) {
                          setState(() {
                            _cancer = value!;
                          });
                        },
                      ),
                      Text("Cancer"),
                    ],
                  );
    final cardiacField = Row(
                    children: [
                      Checkbox(
                        value: _cardiac,
                        onChanged: (bool? value) {
                          setState(() {
                            _cardiac = value!;
                          });
                        },
                      ),
                      Text("Cardiac Disease"),
                    ],
                  );
    final diabetesField = Row(
                    children: [
                      Checkbox(
                        value: _diabetes,
                        onChanged: (bool? value) {
                          setState(() {
                            _diabetes = value!;
                          });
                        },
                      ),
                      Text("Diabetes"),
                    ],
                  );
    final tensionField = Row(
                    children: [
                      Checkbox(
                        value: _hypertension,
                        onChanged: (bool? value) {
                          setState(() {
                            _hypertension = value!;
                          });
                        },
                      ),
                      Text("Hyper Tension"),
                    ],
                  );
    final psychiatricField = Row(
                    children: [
                      Checkbox(
                        value: _psychiatric,
                        onChanged: (bool? value) {
                          setState(() {
                            _psychiatric = value!;
                          });
                        },
                      ),
                      Text("Psychiatric Disorder"),
                    ],
                  );
    final epilepsyField = Row(
                    children: [
                      Checkbox(
                        value: _epilepsy,
                        onChanged: (bool? value) {
                          setState(() {
                            _epilepsy = value!;
                          });
                        },
                      ),
                      Text("Epilepsy"),
                    ],
                  );

    final tobaccoField = DropdownButtonFormField(
                    value: _tobacco,
                    decoration: InputDecoration(
                      labelText: "Have you ever used any tobacco?",
                    ),
                    items: TobaccoAnswers.map((TobaccoOption) {
                      return DropdownMenuItem(
                        value: TobaccoOption,
                        child: Text(TobaccoOption),
                      );
                    }).toList(),
                    onChanged: (selectedAns) {
                      setState(() {
                        _tobacco = selectedAns!;
                      });
                    },
                  );

    final weightField =  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    controller: _weight,
                    onSaved: (value){
                      _weight.text = value!;
                    },
                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                                    ],
                    decoration: InputDecoration(
                      labelText: "Weight (kgs)",
                       suffix: Text(
                            "*",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                            ),
                          ),
                    ),
                  );
    final heightField = TextFormField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    controller: _height,
                    onSaved: (value){
                      _height.text = value!;
                    },
                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                                    ],
                    decoration: InputDecoration(
                      labelText: "Height (cm)",
                       suffix: Text(
                            "*",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                            ),
                          ),
                    ),
                  );
    final maritalField = DropdownButtonFormField(
                    value: _marital,
                    decoration: InputDecoration(
                      labelText: "Marital Status",
                    ),
                    items: MaritalAnswers.map((MaritalOption) {
                      return DropdownMenuItem(
                        value: MaritalOption,
                        child: Text(MaritalOption),
                      );
                    }).toList(),
                    onChanged: (selectedAnswer) {
                      setState(() {
                        _marital = selectedAnswer!;
                      });
                    },
                  );
    final Text1Field = Container(
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
                  );

    final Text2Field = Container(
                    height: 150,
                    //child: SingleChildScrollView(
                    child: TextField(
                      maxLines: 4,
                      controller: _textbox2,
                      decoration: InputDecoration(
                        hintText: "Enter text here",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
    final Text3Field = Container(
                    height: 150,
                    //child: SingleChildScrollView(
                    child: TextField(
                      maxLines: 4,
                      controller: _textbox3,
                      decoration: InputDecoration(
                        hintText: "Enter text here",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Edit Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    // Column(
                    children: [
                      FirstNameField,
                      LastNameField,
                     
                     
                     
                      genderField,
                      phoneField,
                      dateField,
                      areaField,
                      bloodgroupField,
                      

                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Mark All that Apply",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      asthmaField,
                      cancerField,
                      cardiacField,
                      diabetesField,
                      tensionField,
                      psychiatricField,
                      epilepsyField,
                      tobaccoField,
                      weightField,
                      heightField,
                      maritalField,

                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Please list any medications that you're taking",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                       Text1Field,

                       Text(
                          "Any special needs?",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        Text2Field,

                        Text(
                          "Any additional Information?",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        Text3Field,
 



                      ElevatedButton(
                          onPressed: () async {

                            

                            final firstName = _FnameTextController.text;
                            final lastName = _LnameTextController.text;
                            final confirmedPassword = _confirmpassTextController.text;
                            final cnic = _cnic.text;
                            final gender = _gender.toString();
                            final phone = _phonenumb.text;
                            final dateofbirth = DateFormat('dd/MM/yyyy')
                                      .format(_selectedDate);
                            final area = _Area.toString();
                            final bloodGroup = _bloodgroup.toString();
                            final asthma = _asthma;
                            final cancer = _cancer;
                            final cardiac = _cardiac;
                            final diabetes = _diabetes;
                            final tension = _hypertension;
                            final psychiatric = _psychiatric;
                            final epilepsy = _epilepsy;
                            final tobacco = _tobacco.toString();
                            final weight = _weight.text;
                            final height = _height.text;
                            final marital = _marital.toString();
                            final textBox1 = _textbox1.text;
                            final textBox2 = _textbox2.text;
                            final textBox3 = _textbox3.text;
                            final userid = uid;



                            AuthService2 authService = AuthService2();
                            String? errorMessage = await authService.createUserWithEmailAndPassword(userid, firstName, lastName, confirmedPassword, cnic, gender, phone, dateofbirth, area, bloodGroup, asthma, cancer, cardiac, diabetes, tension, psychiatric, epilepsy, tobacco, weight, height, marital, textBox1, textBox2, textBox3);

                            if (errorMessage != 'Account Registered'){

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  padding: const EdgeInsets.all(16),
                                  height: 75,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFC72C41),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  //child: Text(errorMessage.toString()),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    const Text("Error!", 
                                    style: TextStyle(fontSize: 15, color: Colors.white)),
                                    Text(errorMessage.toString() , 
                                    style: TextStyle(fontSize: 14, color: Colors.white)),
                                  ]
                                  )
                                  
                                )
                                
                                
                                
                                //Text(errorMessage.toString())
                              ),
                            );
                            }

                            if (errorMessage.toString() == 'Account Registered'){
                              Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return UserProfile(uid: userid, firstName: firstName, lastName: lastName,
                                             dateofbirth: dateofbirth, gender: gender, marital: marital,
                                             cnic: cnic, blood: bloodGroup, height: height, weight: weight,
                                             asthma: asthma,  cancer: cancer,  cardiac: cardiac,  
                                             diabetes: diabetes, tension: tension,  epilepsy: epilepsy,  
                                             psych: psychiatric, tobacco: tobacco, additional: textBox3,
                                             medication: textBox1,  special: textBox2, area: area,
                                             phone: phone
                          );
                        }));
                        
                        }
                            
                            
                           
                            
                           
                          },
                          child: Text("Update Account Information")),
                    ],
                  ))
            ],
          ),
        ),
    ),
    );
  }
}
