import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChartsProvider extends ChangeNotifier{
  ChartsProvider(){
    _fetchUserDetails();
  }
  String _currentUserName='???';
  Future<String> _fetchUserDetails() async{
    String uid=FirebaseAuth.instance.currentUser!.uid;
    print('I was outside');
    FirebaseFirestore.instance.collection('Users/').doc(uid).snapshots().listen((event) {
      _currentUserName =event['Username'];
      notifyListeners();
      print('I was inside');
    });

    return _currentUserName;
  }


  String get currentUser{
    return _currentUserName;
  }


}