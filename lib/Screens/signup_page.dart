import 'package:flutter/material.dart';
import 'package:my_araby_ai/widgets/signin/signin_w2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emaildFocusNode = FocusNode();
  String _hintText = 'you@example.com';

  @override
  void initState() {
    super.initState();
    _emaildFocusNode.addListener(() {
      setState(() {
        _hintText = _emaildFocusNode.hasFocus ? '' : 'you@example.com';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _emaildFocusNode.dispose();
  }

  Future<void> _goToNextPage() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Get the email entered by the user
      String email = _emailController.text.trim();

      // Here, you can optionally save the email locally or proceed to the next page.
      
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('user_email', email);
      // For now, just move to the next page (password page).
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => SingupW2(email: email),  // Pass email to next page
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
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
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset('assets/images/cross.png', width: 32.w, height: 32.h),
                        )
                      ],
                    ),
                    SizedBox(height: 38.h),
                    Image.asset(
                      'assets/images/Dot1.png',
                      width: 40.w,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Hi there,',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'Please enter your e-mail address',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _emailController,
                        focusNode: _emaildFocusNode,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          hintText: _hintText,
                          hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: const Color(0xFFC7C7C7)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          String emailPattern =
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                          RegExp regex = RegExp(emailPattern);
                          if (!regex.hasMatch(value)) {
                            return 'Enter a valid email address';
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
                        onPressed: _goToNextPage,
                        minWidth: double.infinity,
                        height: 45.h,
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
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
                            'assets/images/messageRobot.png',
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
