import 'package:flutter/material.dart';
import 'package:my_araby_ai/widgets/signin/last.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CheckEmail extends StatelessWidget {
  final String usernames;
  const CheckEmail({required this.usernames, Key? key}): super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        
            SizedBox(height: 130.h,),
        
            Image.asset('assets/images/email.png', width: 352.w, height: 320.h,),
        
            SizedBox(height: 50.h,),
        
        
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                textAlign: TextAlign.center,
                'A verification e-mail has been sent to your address',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
        
          
            SizedBox(height: 169.h,),
        
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF3CC8EB),
                              Color(0xFF1171D8)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                              Navigator.pushReplacement(context,
                               MaterialPageRoute(builder: (context) => Explore(username: usernames)));
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
        
            SizedBox(height: 24.h,),
        
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Haven't receive a verification ? ",
                            style: TextStyle(
                              fontSize: constraints.maxWidth > 400 ? 14.sp : 11.sp,
                              color: const Color(0xFF757575),
                              fontFamily: 'Poppins'
                            ),
                          ),
                  InkWell(
                        onTap: (){
                               
                
                       },
                        child: Text(
                              ' Resend E-mail',
                              style: TextStyle(
                                color: const Color(0xFF3CC8EB),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                                fontSize: constraints.maxWidth > 400 ? 14.sp : 11.sp,
                               ),
                              )
                            ),
                      ]),
            ),
        
          ],
        );
  }),
    );
  }
}