import 'package:flutter/material.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Plans extends StatefulWidget {
  const Plans({super.key});

  @override
  State<Plans> createState() => _PlansState();
}

List<String> plans = ['Trial', 'Basic', 'Pro'];

class _PlansState extends State<Plans> {
  bool isSwitched = true;

  String currentPlan = plans[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose Your Plan',
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/cross.png',
                    width: 32.w,
                    height: 32.h,
                  ),
                )
              ],
            ),
            SizedBox(height: 30.h,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Monthly  ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Transform.rotate(
                      angle: 3.14159,
                      child: Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeColor: const Color.fromARGB(255, 255, 255,
                            255), // Switch color when active (Annual)
                        inactiveThumbColor: Colors
                            .grey, // Switch thumb color when inactive (Monthly)
                        inactiveTrackColor:
                            Colors.grey[300], // Track color when inactive
                        activeTrackColor:
                            const Color(0xFF3CC8EB), // Track color when active
                      ),
                    ),
                    Text(
                      '  Annual',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPlan = plans[0];
                        });
                      },
                      child: Container(
                        width: 178.w,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: -7,
                                  blurRadius: 16,
                                  offset: Offset(4, 4))
                            ],
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF47C9FC),
                                const Color(0xFFDB63C3)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [
                              Radio(
                                  activeColor: const Color(0xFFd851ef),
                                  value: plans[0],
                                  groupValue: currentPlan,
                                  onChanged: (value) {
                                    setState(() {
                                      currentPlan = value.toString();
                                    });
                                  }),
                              Text(
                                'Trial',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Image.asset(
                                'assets/images/rocket1.png',
                                width: 88.w,
                                height: 88.h,
                              ),
                              Text(
                                'Free',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 10.h,),
                              Text(
                                textAlign: TextAlign.center,
                                '2,500 words \n20images',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPlan = plans[1];
                        });
                      },
                      child: Container(
                        width: 178.w,
                        
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: -7,
                                  blurRadius: 16,
                                  offset: Offset(4, 4))
                            ],
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFa9e3fe),
                                const Color(0xFF42a6fd)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [
                              Radio(
                                  activeColor: const Color(0xFFd851ef),
                                  value: plans[1],
                                  groupValue: currentPlan,
                                  onChanged: (value) {
                                    setState(() {
                                      currentPlan = value.toString();
                                    });
                                  }),
                              Text(
                                'Basic',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/clouds.png',
                                    width: 150.w,
                                    height: 66.28.h,
                                  ),
                                  Positioned(
                                    top: -10,
                                    child: Image.asset(
                                      'assets/images/rocket2.png',
                                      width: 88.w,
                                      height: 88.h,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Text(
                                '\$ 9.99',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                'Monthly',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 10.h,),
                              Text(
                                textAlign: TextAlign.center,
                                '45,000 words \n100 images',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h,),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentPlan = plans[2];
                      });
                    },
                    child: Container(
                      width: 178.w,
                      
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: -7,
                                blurRadius: 16,
                                offset: Offset(4, 4))
                          ],
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF3e98fb),
                              const Color(0xFFa070f0)
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          children: [
                            Radio(
                              activeColor: const Color(0xFFd851ef),
                              value: plans[2],
                              groupValue: currentPlan,
                              onChanged: (value) {
                                setState(() {
                                  currentPlan = value.toString();
                                });
                              },
                            ),
                            Text(
                              'Pro',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Stack(alignment: Alignment.center, children: [
                              Image.asset(
                                'assets/images/stars.png',
                                width: 150.w,
                                height: 71.13.h,
                              ),
                              Positioned(
                                top: -7,
                                child: Image.asset(
                                  'assets/images/rocket3.png',
                                  width: 88.w,
                                  height: 88.h,
                                ),
                              )
                            ]),
                            Text(
                              '\$ 29.99',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'Monthly',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10.h,),
                            Text(
                              textAlign: TextAlign.center,
                              '150,000 words \n200 images',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35.h,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(colors: [
                      Color(0xFF3CC8EB),
                      Color(0xFF1171D8)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: double.infinity,
                    height: 44.h,
                    child: Text(
                      'Try it NOW',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp),
                    ),
                  ),
                ),
                kGap15,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Need more? ",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color.fromARGB(201, 49, 47, 47),
                        fontFamily: 'Poppins'),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Text(
                        ' Contact us',
                        style: TextStyle(
                          fontSize: 14.sp,
                            color: const Color.fromARGB(255, 108, 213, 240),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins'),
                      )
                    ),
                  ]
                  )
                  ]
                  ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
