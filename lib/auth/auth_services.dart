import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  Future<String?> createUserWithEmailAndPassword(String email, String password, 
                                                String firstName, String lastName, 
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

      String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // regular expression pattern

      if (RegExp(emailRegex).hasMatch(email)!= true){
        return "Email is not Valid.";
      }

      if (password == ""){
        return "Password cannot be empty.";
      }

      if (confirmedPassword == ""){
        return "Confirmed Password cannot be empty.";
      }

      if (confirmedPassword != password){
        return "Password did not match. Try Again";
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
       
      CollectionReference collectionRef =  FirebaseFirestore.instance.collection('cnicCollection');
      DocumentReference documentRef = collectionRef.doc(cnic);
       
      DocumentSnapshot documentSnapshot = await documentRef.get();

       

      if (documentSnapshot.exists) {
        return "An account with this CNIC already exists.";
      } 
      



      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user!;
      // Update the user's display name with their first name
      await user.updateDisplayName(firstName);
      

      await FirebaseFirestore.instance.collection('cnicCollection').doc(cnic).set({
        'cnic': cnic
      });


      // Create a Firestore document for the user with additional information
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
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

      final FirebaseAuth _auth = FirebaseAuth.instance;
      
     
      //print(email);
      try {
        UserCredential newUserCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        User newUser = newUserCredential.user!;
        await newUser.sendEmailVerification();
        
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          return 'The account already exists for that email.';
        }
      } catch (e) {
        return 'An error occurred while signing up.';
      }


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
