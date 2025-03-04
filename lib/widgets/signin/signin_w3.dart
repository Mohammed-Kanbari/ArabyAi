import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Import SharedPreferences
import 'package:my_araby_ai/widgets/signin/check_email.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingupW3 extends StatefulWidget {
  const SingupW3({super.key});

  @override
  State<SingupW3> createState() => _SingupW3State();
}

class _SingupW3State extends State<SingupW3> {
  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  String _hintText = 'Username';
  

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {
        _hintText = _usernameFocusNode.hasFocus ? '' : 'Username';
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _usernameFocusNode.dispose();
    super.dispose();
  }

   Future<void> _saveUsernameToFirestore(String username) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
          String uid = FirebaseAuth.instance.currentUser!.uid;

      // Assuming you want to save the username under a collection 'users'
      await firestore.collection('Users').doc(uid).set({
        'name': username,
        'created_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error saving username: $e");
    }
  }

  // Function to save username to SharedPreferences
  // Future<void> _saveUsername(String username) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('username', username); // Save the username
  // }

    final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80.h),
                    Image.asset('assets/images/Dot3.png', width: 40.w),
                    SizedBox(height: 20.h),
                    Text(
                      "Let's Pick you a username!",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        focusNode: _usernameFocusNode,
                        controller: _usernameController, // Set controller
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          hintText: _hintText,
                          hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: const Color(0xFFC7C7C7)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.replay_outlined, color: Colors.blue),
                            onPressed: () {
                              _usernameController.clear(); // Reset username field
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'username cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3CC8EB),
                            Color(0xFF1171D8),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          String username = _usernameController.text.trim();
                          // Save username locally when 'Done' is pressed
                          await _saveUsernameToFirestore(username);

                          if (_formKey.currentState?.validate() ?? false) {
                             Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckEmail()),
                            (route) => false,
                          );
                          }

                         
                        },
                        minWidth: double.infinity,
                        height: 45.h,
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 43, bottom: 15),
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/messageRobot3.png',
                            width: 321.w,
                            height: 310.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
