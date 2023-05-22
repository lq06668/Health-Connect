import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService2 {
  Future<String?> createUserWithEmailAndPassword(String uid, String firstName, String lastName, 
                                                String confirmedPassword, String cnic, 
                                                String gender, String phone, 
                                                String dateofbirth, String area, 
                                                String bloodGroup, bool asthma, 
                                                bool cancer, bool cardiac,
                                                bool diabetes, 
                                                bool tension, bool psychiatric, 
                                                bool epilepsy, String tobacco, 
                                                String weight, String height, 
                                                String marital, String textBox1,
                                                String textBox2, String textBox3) async {
   
    try {

       
      if (firstName == ""){
        return "First name cannot be empty.";
      }

      if (lastName == ""){
        return "Last name cannot be empty.";
      }

     

     
      if (cnic.length !=  13){
        return "CNIC must be 13 Digits. Try Again.";
      }

      if (cnic == ""){
        return "CNIC cannot be empty";
      }
      

      if (phone.length != 11){
        return "Phone number must be 13 Digits. Try Again.";
      }

      if (phone == ""){
        return "Phone number cannot be empty";
      }

      if (weight == ""){
        return "Weight cannot be empty";
      }

      if (height == ""){
        return "Height cannot be empty";
      }

      if (int.parse(weight) > 360 || int.parse(weight) < 1){
        return "Please add appropriate weight";
      }

      if (int.parse(height) > 300 || int.parse(height) < 1){
        return "Please add appropriate height";
      }

      if (textBox1 == ""){
        textBox1 = "None";
      }

      if (textBox2 == ""){
        textBox2 = "None";
      }

      if (textBox3== ""){
        textBox3 = "None";
      }
       
      
      // Create a Firestore document for the user with additional information
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'cnic': int.parse(cnic),
        'gender': gender,
        'phone': int.parse(phone),
        'dateofbirth': dateofbirth,
        'area': area,
        'bloodgroup': bloodGroup,
        'asthma': asthma,
        'cancer': cancer,
        'cardiac': cardiac,
        'diabetes': diabetes,
        'tension': tension,
        'psychiatric': psychiatric,
        'epilepsy': epilepsy,
        'tobacco': tobacco,
        'weight': int.parse(weight),
        'height': int.parse(height),
        'marital': marital,
        'medicine': textBox1,
        'special needs': textBox2,
        'additional Information': textBox3
      });

      

      return 'Account Registered';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      else if (e.code == 'permission-denied'){
        return "??";
      }
      else if (e.code == 'not-found') {
        return "???";
      }
      else{
        print('Error retrieving document: $e');
        return 'An error occurred ?? 1';
      }
    } catch (e) {

      print('Error retrieving document: $e');
      
      
      return 'Errorrrr';
    }
  }
}
