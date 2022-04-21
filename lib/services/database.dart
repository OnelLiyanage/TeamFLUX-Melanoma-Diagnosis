import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  getUsersByUsername (String username) { 

  }

  uploadUserInfo (userMap) {
    FirebaseFirestore.instance.collection("users") 
      .add(userMap).catchError; (e) {
        print(e.toString());
      } ; 
  }
}