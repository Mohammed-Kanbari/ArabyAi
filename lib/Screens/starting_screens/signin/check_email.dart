import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/starting_screens/signin/last.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckEmail extends StatefulWidget {
  const CheckEmail({super.key});

  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  bool isEmailSentAutomatically = false;

  // Function to send the verification email
  Future<void> _sendVerificationEmail(BuildContext context,
      {bool showSnackbar = true}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        if (showSnackbar) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification email sent!')),
          );
        }
      } catch (e) {
        if (showSnackbar) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Send the email without showing Snackbar when the page is loaded
    _sendVerificationEmail(context, showSnackbar: false);
    // Set the flag to indicate the email was sent automatically
    isEmailSentAutomatically = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 130.h,
            ),
            Image.asset(
              'assets/images/email.png',
              width: 352.w,
              height: 320.h,
            ),
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                textAlign: TextAlign.center,
                'A verification e-mail has been sent to your address',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 169.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                      colors: [Color(0xFF3CC8EB), Color(0xFF1171D8)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    User? user = FirebaseAuth.instance.currentUser;
                    await user?.reload(); // Ensure user data is reloaded
                    if (user != null && user.emailVerified) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Explore()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please verify your email first!')),
                      );
                    }
                  },
                  minWidth: double.infinity,
                  height: 44.h,
                  child: Text(
                    'Check your E-mail',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14.sp),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Haven't receive a verification ? ",
                  style: TextStyle(
                      fontSize: constraints.maxWidth > 400 ? 14.sp : 11.sp,
                      color: const Color(0xFF757575),
                      fontFamily: 'Poppins'),
                ),
                InkWell(
                    onTap: () {
                      _sendVerificationEmail(context);
                    },
                    child: Text(
                      ' Resend E-mail',
                      style: TextStyle(
                        color: const Color(0xFF3CC8EB),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        fontSize: constraints.maxWidth > 400 ? 14.sp : 11.sp,
                      ),
                    )),
              ]),
            ),
          ],
        );
      }),
    );
  }
}
