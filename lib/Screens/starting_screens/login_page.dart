import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/main_screens/HomePage.dart';
import 'package:my_araby_ai/Screens/starting_screens/get_started.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_araby_ai/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign-in method using Firebase Authentication (Email/Password)
  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        User? user = userCredential.user;
        if (user != null) {
          UserProvider provider = context.read<UserProvider>();
          if (provider.username == null || provider.firebaseUid != user.uid) {
            DocumentSnapshot userDoc = await _firestore.collection('Users').doc(user.uid).get();
            provider.setEmail(user.email ?? '');
            provider.setPassword(_passwordController.text.trim(), firebaseUid: user.uid);
            provider.setUsername(userDoc.exists ? userDoc['name'] ?? 'User' : 'User');
            provider.setPhone(userDoc.exists ? userDoc['phone'] ?? '123456789' : '123456789');
            provider.setProfilePictureUrl(userDoc.exists ? userDoc['profilePictureUrl'] : null);
            provider.setOccupation(userDoc['occupation'] ?? '');
            provider.setDob(userDoc['dob'] ?? '');
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    }
  }

  // Sign-in method using Google
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; // User canceled

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // Check if user exists in Firestore, create if not
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
        UserProvider provider = context.read<UserProvider>();

        if (!userDoc.exists) {
          // New user, create document
          await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
            'email': user.email,
            'name': user.displayName ?? 'User', // Use Google displayName as default
            'phone': '+971 123456789', // Default phone
            'profilePictureUrl': user.photoURL, // Google profile picture if available
            'occupation': '',
            'dob': '',
            'created_at': FieldValue.serverTimestamp(),
          });
          provider.setEmail(user.email ?? '');
          provider.setPassword('', firebaseUid: user.uid); // No password for Google Sign-In
          provider.setUsername(user.displayName ?? 'User');
          provider.setPhone('123456789');
          provider.setProfilePictureUrl(user.photoURL);
          provider.setOccupation('');
          provider.setDob('');
        } else {
          // Existing user, update UserProvider with Firestore data
          provider.setEmail(userDoc['email'] ?? user.email ?? '');
          provider.setPassword('', firebaseUid: user.uid);
          provider.setUsername(userDoc['name'] ?? 'User');
          provider.setPhone(userDoc['phone'] ?? '123456789');
          provider.setProfilePictureUrl(userDoc['profilePic']);
          provider.setOccupation(userDoc['occupation'] ?? '');
          provider.setDob(userDoc['dob'] ?? '');
        }


        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google Sign-In failed: $e')));
      }
    }
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email to reset password.')),
      );
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent! Check your inbox.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:
          true, // This ensures the layout resizes when keyboard appears

      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: [
                                SizedBox(height: 50.h),
                                Image.asset('assets/images/arabyLogo.png',
                                    width: 45.w, height: 50.h),
                                SizedBox(height: 24.h),
                                Text(
                                  "Let's sign you in",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: constraints.maxWidth > 400
                                        ? 24.sp
                                        : 22.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Welcome back, you have been missed !',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: constraints.maxWidth > 400
                                        ? 16.sp
                                        : 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    constraints.maxHeight > 800 ? 80.h : 60.h),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'E-mail Address :',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      hintText: 'Enter your email',
                                      hintStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w300),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue,
                                            width:
                                                2.w), // Blue color when focused
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFC7C7C7),
                                            width: 1
                                                .w), // Grey color when not focused
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onChanged: (String value) {},
                                    validator: (value) {
                                      return value!.isEmpty
                                          ? 'Please enter email'
                                          : null;
                                    },
                                  ),
                                  SizedBox(height: 23.h),
                                  Text(
                                    'Password :',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  TextFormField(
                                    controller: _passwordController,
                                    autocorrect: false,
                                    obscureText: _obscurePassword,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      hintText: 'Enter your password',
                                      hintStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w300),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2.w),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFC7C7C7),
                                            width: 1.w),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          color: const Color.fromARGB(
                                              255, 146, 139, 139),
                                          _obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                      ),
                                    ),
                                    onChanged: (String value) {},
                                    validator: (value) {
                                      return value!.isEmpty
                                          ? 'Please enter password'
                                          : null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  GestureDetector(
                                    onTap: _resetPassword,
                                    child: Text(
                                      'Forget Password ?',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF787579)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 39.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF3CC8EB),
                                              Color(0xFF1171D8)
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight)),
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          _signIn();
                                        }
                                      },
                                      minWidth: double.infinity,
                                      height: 45.h,
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 80.h,
                            ),
                            Spacer(),
                            Text(
                              '- OR -',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/facebook.png',
                                    width: 50.w,
                                    height: 50.h,
                                  ),
                                ),
                                SizedBox(
                                  width: 22.w,
                                ),
                                IconButton(
                                  onPressed: () {
                                    _signInWithGoogle(context);
                                  },
                                  icon: Image.asset(
                                    'assets/images/googleLogo2.png',
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                ),
                                SizedBox(
                                  width: 22.w,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/appleIcon2.png',
                                    width: 50.w,
                                    height: 50.h,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color(0xFF757575),
                                          fontFamily: 'Poppins'),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GetStarted()),
                                              (route) => false);
                                        },
                                        child: Text(
                                          ' Sign up',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: const Color(0xFF3CC8EB),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins'),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
