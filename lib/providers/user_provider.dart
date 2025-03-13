import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _email;
  String? _password;
  String? _firebaseUid;
  String? _username;
  String? _phone;
  String? _profilePictureUrl;
  String? _occupation;
  String? _dob;

  String? get email => _email;
  String? get password => _password;
  String? get firebaseUid => _firebaseUid;
  String? get username => _username;
  String? get phone => _phone;
  String? get profilePictureUrl => _profilePictureUrl;
  String? get occupation => _occupation;
  String? get dob => _dob;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password, {required String firebaseUid}) {
    _password = password;
    _firebaseUid = firebaseUid;
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setPhone(String? phone) {
    _phone = phone;
    notifyListeners();
  }

  void setProfilePictureUrl(String? url) {
    _profilePictureUrl = url;
    notifyListeners();
  }

  void setOccupation(String? occupation) {
    _occupation = occupation;
    notifyListeners();
  }

  void setDob(String? dob) {
    _dob = dob;
    notifyListeners();
  }

  void clear() {
    _email = null;
    _password = null;
    _firebaseUid = null;
    _username = null;
    _phone = null;
    _profilePictureUrl = null;
    _occupation = null;
    _dob = null;
    notifyListeners();
  }

Future<void> fetchUserData() async {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
        if (userDoc.exists) {
          _email = userDoc['email'] ?? user.email ?? '';
          _firebaseUid = user.uid;
          _username = userDoc['name'] ?? 'User';
          _phone = userDoc['phone'] ?? '+971 123456789';
          _profilePictureUrl = userDoc['profilePictureUrl'];
          _occupation = userDoc['occupation'] ?? '';
          _dob = userDoc['dob'] ?? '';
          print('UserProvider fetchUserData - Username: $_username'); // Debug
          notifyListeners();
        }
      } catch (e) {
        debugPrint('Error fetching user data: $e');
      }
    }
  }
}