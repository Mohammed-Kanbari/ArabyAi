import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/HomePage.dart';
import 'package:my_araby_ai/Screens/get_started.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  // Sign-in method using Firebase Authentication
  Future<void> _signIn() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to HomePage on successful login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } catch (e) {
      // Handle any errors during login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google sign-in was canceled.')),
        );
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // Reference Firestore
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentSnapshot userDoc =
            await firestore.collection('Users').doc(user.uid).get();

        if (!userDoc.exists) {
          // New user — add to Firestore
          await firestore.collection('Users').doc(user.uid).set({
            'email': user.email,
            'name': null,
            'password': null,
            'phone': null,
            'occupation': null,
            'dob': null
          });
          print("New user added to Firestore");
        } else {
          // Existing user — retrieve their details
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          print("User details: ${userData['email']}, ${userData['name']}, ${userData['phone']}, ${userData['occupation']}, ${userData['dob']}");
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                              fontSize:
                                  constraints.maxWidth > 400 ? 24.sp : 22.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            textAlign: TextAlign.center,
                            'Welcome back, you have been missed !',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize:
                                  constraints.maxWidth > 400 ? 16.sp : 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: constraints.maxHeight > 800 ? 80.h : 60.h),
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
                                    borderRadius: BorderRadius.circular(8)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2.w), // Blue color when focused
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFFC7C7C7),
                                      width:
                                          1.w), // Grey color when not focused
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
                                    borderRadius: BorderRadius.circular(8)),
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
                                      _obscurePassword = !_obscurePassword;
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
                              onTap: () {},
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.facebook_rounded,
                              size: 50.sp,
                              color: const Color.fromARGB(255, 58, 85, 159),
                            ),
                          ),
                          SizedBox(
                            width: 22.w,
                          ),
                          IconButton(
                            onPressed: _signInWithGoogle,
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
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: constraints.maxWidth * 0.03),
                              child: Row(
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
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
