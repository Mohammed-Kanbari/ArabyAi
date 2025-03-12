import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _email;
  String? _password;
  String? _firebaseUid;
  String? _username;
  String? _phone;
  String? _profilePictureUrl;

  String? get email => _email;
  String? get password => _password;
  String? get firebaseUid => _firebaseUid;
  String? get username => _username; // Clearer getter name
  String? get phone => _phone;
  String? get profilePictureUrl => _profilePictureUrl;

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

  void clear() {
    _email = null;
    _password = null;
    _firebaseUid = null;
    _username = null;
    _phone = null;
    _profilePictureUrl = null;
    notifyListeners();
  }
}