import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'package:flutter/material.dart';
import 'package:my_araby_ai/widgets/signin/signin_w3.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class SingupW2 extends StatefulWidget {
  final String email; // Pass the email from the first page
  const SingupW2({super.key, required this.email});

  @override
  State<SingupW2> createState() => _SingupW2State();
}

class _SingupW2State extends State<SingupW2> {
  // State to manage password visibility
  bool _isPasswordVisible = false;

  // Form key to validate form
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  String _hintText = 'Minimum 8 characters';

  @override
  void initState() {
    super.initState();
    // Add a listener to track focus changes
    _passwordFocusNode.addListener(() {
      setState(() {
        _hintText = _passwordFocusNode.hasFocus ? '' : 'Minimum 8 characters';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
  }

  // Firebase signup method
  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.email, // Get the email from the first page
        password: _passwordController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user?.uid)
          .set({
        'email': widget.email,
        'password': _passwordController.text.trim(),
        'phone': null,
        'occupation': null,
        'dob': null
      }).timeout(Duration(seconds: 5), onTimeout: () {
        throw FirebaseException(
            message: "Firestore operation timed out.", plugin: '');
      });

      // After successful signup, navigate to the next page (username)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingupW3(), // Third page for the username
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? 'An error occurred';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

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
                    Image.asset('assets/images/Dot2.png', width: 40.w),
                    SizedBox(height: 20.h),
                    Text(
                      'Now secure it with password',
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'Please enter your a password',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 20.h),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          hintText: _hintText,
                          hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: const Color(0xFFC7C7C7))),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          if (value.length < 8 || value.length > 16) {
                            return 'Password must be between 8 and 16 characters';
                          }
                          if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                            return 'Password must contain at least one lowercase letter';
                          }
                          if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                            return 'Password must contain at least one uppercase letter';
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
                          colors: [Color(0xFF3CC8EB), Color(0xFF1171D8)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _signUp(); // Call the sign-up method
                          }
                        },
                        minWidth: double.infinity,
                        height: 45.h,
                        child: Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14.sp),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 43, bottom: 15),
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset('assets/images/messageRobot2.png',
                              width: 321.w, height: 310.h),
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
