import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/main_screens/HomePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_araby_ai/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 160.h,
          ),
          Image.asset(
            'assets/images/verify-security.png',
            width: 271.w,
            height: 260.h,
          ),
          SizedBox(
            height: 80.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Consumer<UserProvider>(builder: (context, provider, child) {
              final username = provider.username ?? 'User';
              return RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Hi ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                    TextSpan(
                        text: '$username, ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1171D8))),
                    TextSpan(
                        text:
                            'Your email has been verified successfully in our system.',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black))
                  ]));
            }),
          ),
          SizedBox(
            height: 169,
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
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                minWidth: double.infinity,
                height: 44.h,
                child: Text(
                  'Explore Now',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
