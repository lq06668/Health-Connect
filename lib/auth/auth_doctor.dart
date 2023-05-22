import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService4 {
  Future<String?> DoctorAdd(String docid, String doctorname, String education, String Experience, String specialization
                            ,String about
  ) async {
   
    try {

      //await FirebaseFirestore.instance.collection('Hospital').add({
       // 'hospitalname': name,
      //  'hospitaladdress': Address
       
      //});
      FirebaseFirestore.instance
        .collection('Hospital')
        .doc(docid)
        .collection('doctors')
        .add({
        // add your data here
            'doctorName': doctorname,
            'specialization': specialization,
            'about': about,
            'experience': Experience,
            'education': education,
            'reviews': {
              'good': 0,
              'bad': 0,
              'medium': 0
            },
        });

      return "woo";
     
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
