import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService3 {
  Future<String?> hospitalAdd(String name, String Address) async {
   
    try {

      if (name == ''){
        return "Name cannot be empty";
      }
      if (Address == ''){
        return 'Address Cannot be empty';
      }

      await FirebaseFirestore.instance.collection('Hospital').add({
        'hospitalname': name,
        'hospitaladdress': Address
        
       
      });
      
      return "Hospital Added Successfully";
     
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
