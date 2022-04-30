// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:chat_ui/modal/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {

  final FirebaseAuth auth = FirebaseAuth.instance;

// retrive user id from firebase 
  userdata? _userFromFirebaseUser (User user ) {
    return user != null ? userdata(userId : user.uid ) : null   ;
  }

// Sign in method
  Future signInWithEmailAndPassword (String email, String password)  async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword
        (email: email, password: password);
      User firebaseUser = result.user as User ;
      return _userFromFirebaseUser(firebaseUser);
    
    } catch (e) {
      print(e.toString());
    }

  }

// Sign up method
  Future signUpwithEmailAndPassword (String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword
          (email: email, password: password);
      User firebaseUser = result.user as User;
      return _userFromFirebaseUser(firebaseUser);

    } catch (e) {
      print(e.toString());
    }
  }

// Sign out from app
  Future signOut() async {
    try {
      return await auth.signOut();

    } catch (e) {
      print(e.toString());
    }
  }

}
