import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/auth/auth_services.dart';
import 'package:flutter_application_1/screens/patient_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/verify_email.dart';


class Patient_SignUp extends StatefulWidget {
  @override
  _Patient_SignUpState createState() => _Patient_SignUpState();
}

class _Patient_SignUpState extends State<Patient_SignUp> {

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

  @override
  void initState(){
    _email = TextEditingController();
    _password = TextEditingController();
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

  String _gender = 'Male';
  final genderOptions = ['Male', 'Female', 'Other'];
  DateTime _selectedDate = DateTime.now();
  
  String _Area = "DHA Phase 6";
  final areaOptions = ["DHA Phase 6", "DHA Phase 5", "DHA Phase 1", "DHA Phase 2"];

  String _bloodgroup = 'A+';
  final bloodgroupOptions = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  bool _asthma = false;
  bool _cancer = false;
  bool _cardiac = false;
  bool _diabetes = false;
  bool _hypertension = false;
  bool _psychiatric = false;
  bool _epilepsy = false;


  String _tobacco = 'No';
  final TobaccoAnswers = ['Yes', 'No'];

  String _marital = 'Single';
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
                          
                          suffixIcon: Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
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
                          
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(left: 42.0),
                            child: Text(
                              "*",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.0,
                              ),
      ),
    ),
                      ),
    );
    
    final emailField = TextFormField(
      controller: _email,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      decoration: InputDecoration(
                        labelText: "Email",
                          
                           suffixIcon: Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                      ),
    );

    final passwordField = TextFormField(
      enableSuggestions: false,
      autocorrect: false,
      controller: _password,
      validator: (value) {
        RegExp regex = RegExp(r"^.{6,}$");
        if (value!.isEmpty) {
          return ("Password is required for sign up");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
                          
                           suffixIcon: Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
      ),
    );

    final confirmPasswordField = TextFormField(
      enableSuggestions: false,
      autocorrect: false,
      controller: _confirmpassTextController,
      validator: (value) {
        RegExp regex = RegExp(r"^.{6,}$");
        if (value!.isEmpty) {
          return ("Password is required for sign up");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        if (value!=_password.text){
          return ("Password Does not Match");
        }
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Confirmed Password",
                           suffixIcon: Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
      ),
    );
    
    final cnicFied = TextFormField(
      controller: _cnic,

      onSaved: (value){
        _cnic.text = value!;
      },
      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
      
      decoration: InputDecoration(
                        labelText: "CNIC",
                          suffixIcon: Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
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
                          suffixIcon: Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
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
                                             suffixIcon: Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
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
                    //keyboardType: TextInputType.numberWithOptions(decimal: true),
                    controller: _weight,
                    
                   
                    decoration: InputDecoration(
                      labelText: "Weight (kgs)",
                        suffixIcon: Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                    ),
                  );
    final heightField = TextFormField(
                    //keyboardType: TextInputType.numberWithOptions(decimal: true),
                    controller: _height,
                   
                    
                    decoration: InputDecoration(
                      labelText: "Height (cm)",
                        suffixIcon: Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
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
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Patients Signup Page",
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
                      emailField,
                      passwordField,
                      confirmPasswordField,
                      cnicFied,
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

                            

                            final email = _email.text;
                            final password = _password.text;
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



                            AuthService authService = AuthService();
                            String? errorMessage = await authService.createUserWithEmailAndPassword(email, password, firstName, lastName, confirmedPassword, cnic, gender, phone, dateofbirth, area, bloodGroup, asthma, cancer, cardiac, diabetes, tension, psychiatric, epilepsy, tobacco, weight, height, marital, textBox1, textBox2, textBox3);

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

                              final FirebaseAuth _auth = FirebaseAuth.instance;
                              UserCredential newUserCredential = await _auth.signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                User user = newUserCredential.user!;

                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              
                                return verify_Email(email:email, password:password, user:user );
                            })
                            );
                            }
                            
                           
                            
                           
                          },
                          child: Text("Sign Up")),
                    ],
                  ))
            ],
          ),
        ),
    ),
    );
  }
}
