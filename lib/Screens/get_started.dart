import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/Login_page.dart';
import 'package:my_araby_ai/Screens/signup_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50.h),
                  Image.asset('assets/images/arabyLogo.png',
                      width: 45.w, height: 50.h),
                   SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Getting started',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Create an account to continue !',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 41.h,
                  ),
                  Text(
                    '- USE - ',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF47C9FC),
                                    Color(0xFF0084FC)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.phone_iphone),
                              iconSize: 64.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Text(
                            'Phone',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins'
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF47C9FC),
                                    Color(0xFF0084FC)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Singup()),
                                );
                              },
                              icon: Icon(Icons.email_outlined),
                              iconSize: 64.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Text(
                            'E-mail',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins'
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 77.h,
                  ),
                  Text(
                    '- OR -',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Poppins'
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.facebook_rounded,
                          size: 55.sp,
                          color: const Color.fromARGB(255, 58, 85, 159),
                        ),
                      ),
                      SizedBox(
                        width: 22.w,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/googleLogo2.png',
                          width: 50.w,
                          height: 50.h,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/appleIcon2.png',
                          width: 60.w,
                          height: 60.h,
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'By Registering you agree to our ',
                                style: TextStyle(
                                    fontSize:constraints.maxWidth > 400 ? 12.sp : 9.sp,
                                    color: const Color.fromARGB(202, 0, 0, 0),
                                    fontFamily: 'Poppins'),
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'Terms of Use',
                                    style: TextStyle(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                        fontSize: constraints.maxWidth > 400 ? 12.sp : 9.sp),
                                  )),
                              Text(
                                ' and ',
                                style: TextStyle(
                                    fontSize: constraints.maxWidth > 400 ? 12.sp : 9.sp,
                                    color: const Color.fromARGB(202, 0, 0, 0),
                                    fontFamily: 'Poppins'),
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                        fontSize: constraints.maxWidth > 400 ? 12.sp : 9.sp),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: constraints.maxWidth*0.07),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have and account?',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xFF757575),
                                      fontFamily: 'Poppins'),
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                      );
                                    },
                                    child: Text(
                                      ' Log in',
                                      style: TextStyle(
                                          color: const Color(0xFF3CC8EB),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins',
                                          fontSize: 14.sp),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
