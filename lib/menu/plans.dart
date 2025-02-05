import 'package:flutter/material.dart';
import 'package:my_araby_ai/core/constatns.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose Your Plan',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/cross.png',
                    width: 32,
                    height: 32,
                  ),
                )
              ],
            ),
            kGap30,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Monthly  ',
                  style: TextStyle(
                    fontSize: 14,
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
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            kGap30,
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
                    width: 178,
                    height: 264,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: -7,
                              blurRadius: 15,
                              offset: Offset(0, 3))
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
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Image.asset(
                          'assets/images/rocket1.png',
                          width: 88,
                          height: 88,
                        ),
                        Text(
                          'Free',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        kGap10,
                        Text(
                          textAlign: TextAlign.center,
                          '2,500 words \n20images',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ],
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
                    width: 178,
                    height: 264,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: -7,
                              blurRadius: 15,
                              offset: Offset(0, 3))
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
                              fontSize: 20,
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
                              width: 150,
                              height: 66.28,
                            ),
                            Positioned(
                              top: -10,
                              child: Image.asset(
                                'assets/images/rocket2.png',
                                width: 88,
                                height: 88,
                              ),
                            ),
                          ],
                        ),
                        kGap5,
                        Text(
                          '\$ 9.99',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Monthly',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        kGap10,
                        Text(
                          textAlign: TextAlign.center,
                          '45,000 words \n100 images',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            kGap30,
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentPlan = plans[2];
                  });
                },
                child: Container(
                  width: 178,
                  height: 264,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: -7,
                            blurRadius: 15,
                            offset: Offset(0, 3))
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
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Stack(alignment: Alignment.center, children: [
                        Image.asset(
                          'assets/images/stars.png',
                          width: 150,
                          height: 71.13,
                        ),
                        Positioned(
                          top: -7,
                          child: Image.asset(
                            'assets/images/rocket3.png',
                            width: 88,
                            height: 88,
                          ),
                        )
                      ]),
                      Text(
                        '\$ 29.99',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'Monthly',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      kGap10,
                      Text(
                        textAlign: TextAlign.center,
                        '150,000 words \n200 images',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            kGap35,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 71, 201, 252),
                  Color.fromARGB(255, 0, 132, 252)
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              ),
              child: MaterialButton(
                onPressed: () {},
                minWidth: double.infinity,
                height: 45,
                child: Text(
                  'Try it NOW',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14),
                ),
              ),
            ),
            kGap15,
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Need more? ",
                style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(201, 49, 47, 47),
                    fontFamily: 'Poppins'),
              ),
              InkWell(
                  onTap: () {},
                  child: Text(
                    ' Contact us',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 108, 213, 240),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins'),
                  )),
            ]),
          ],
        ),
      )),
    );
  }
}
