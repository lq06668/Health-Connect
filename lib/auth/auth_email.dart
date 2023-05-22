import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailAuthService {
  Future<String?> LoginUserWithEmailAndPassword(String email, String password, 
                                                ) async {

    final FirebaseAuth auth = FirebaseAuth.instance;

    if (email == ""){
      return "Please enter an email.";
    }

    if (password == ""){
      return "Password cannot be empty.";
    }


  


    try {

          UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          if (FirebaseAuth.instance.currentUser != null) {
                  bool isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
                  if (isEmailVerified) {
                    return "Yay";
                  } else {
                    return "Please Verify Email to Continue";
                  }
                } else {
                  await FirebaseAuth.instance.signOut();
                  // There is no logged-in user.
          }
              //User user = UserCredential.user'         
          
      return "Yay";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'The email address you have entered has not been registered.';
      }
      else if (e.code == 'wrong-password') {
        return 'Your password is incorrect. Please try again.';
      } 
      else{
        print('Error retrieving document: $e');
        return 'User does not exist';
      }
    } catch (e) {
      return 'Errorrrr';
    }
  }
}
