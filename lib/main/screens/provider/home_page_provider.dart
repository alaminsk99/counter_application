import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // You should import this

class HomePageProvider extends ChangeNotifier {
  int _value = 0;
  String? userName;
  User? currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int get value => _value;
  String? get name => userName;

  HomePageProvider() {
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Fetch user data from Firebase data base
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      if (userDoc.exists) {
        _value = userDoc['counterValue'] ?? 0;
        userName = userDoc['name'];
        notifyListeners();
      }
    }
  }

  void incrementValue() {
    _value++;
    notifyListeners();
    _updateValueInDatabase(_value);
  }

  Future<void> _updateValueInDatabase(int value) async {
    if (currentUser != null) {
      await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).set({
        'counterValue': value,
      }, SetOptions(merge: true));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/login'); // Navigate to login screen and clear the stack
  }
}
