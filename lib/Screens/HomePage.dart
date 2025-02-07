import 'package:flutter/material.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/Screens//type_of_contents/Email%20Page/E-mails_page.dart';
import 'package:my_araby_ai/Screens//type_of_contents/SocailM%20Page/sm_main.dart';
import 'package:my_araby_ai/Screens//type_of_contents/images_page.dart';
import 'package:my_araby_ai/widgets/topBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Topbar(),
                kGap25,
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // The TextColumn for two lines of text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello Username,',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'How may I help you \ntoday?',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          // Image spanning both lines
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                'assets/images/robot.png',
                                width: 140,
                                height: 130,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Choose the type of content you would like to create for now :',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: -25, // Horizontal spacing
                  runSpacing: -15, // Vertical spacing
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context,
                           MaterialPageRoute(builder: (context) => Image_Page()));
                        },
                        icon: Image.asset('assets/home_imgs/1.png',
                            width: 135, height: 135)),
        
                    IconButton(
                        onPressed: () {
                          Navigator.push(context,
                           MaterialPageRoute(builder: (context) => SmMain()));
                        },
                        icon: Image.asset('assets/home_imgs/2.png',
                            width: 135, height: 135)),
        
                    IconButton(
                        onPressed: () {
                          Navigator.push(context,
                           MaterialPageRoute(builder: (context) => Email_Page()));
                        },
                        icon: Image.asset('assets/home_imgs/3.png',
                            width: 135, height: 135)),
        
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/home_imgs/4.png',
                            width: 135, height: 135)),
        
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/home_imgs/5.png',
                            width: 135, height: 135)),
        
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/home_imgs/6.png',
                            width: 135, height: 135)),
        
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/home_imgs/7.png',
                            width: 135, height: 135)),
        
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/home_imgs/8.png',
                            width: 135, height: 135)),
                            
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/home_imgs/9.png',
                            width: 135, height: 135)),
                  ],
                ),
                kGap20,
                Padding(
                  padding: kHorizontal25,
                  child: Container(
                    width: 400,
                    height: 385,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 130, 211, 250),
                              const Color.fromARGB(255, 205, 114, 202)
                            ],
                            stops: [
                              0.3,
                              0.8
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 24),
                              child: Text(
                                'Trial Plan',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12, top: 8),
                              child: Image.asset(
                                'assets/images/rocket.png',
                                width: 100,
                                height: 100,
                              ),
                            )
                          ],
                        ),
                        kGap10,
            
                        Padding(
                          padding: kHorizontal20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Word count',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
            
                                  Text(
                                    '20%',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
            
                                ],
                              ),
            
                              kGap10,
            
                              LinearProgressIndicator(
                                value: 0.2, // Progress percentage (20%)
                                backgroundColor: Colors.white.withOpacity(0.4),
                                color: Colors.blue,
                                minHeight: 13,
                                borderRadius: BorderRadius.circular(15),
                              ),
            
                              kGap10,
            
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '500',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
            
                                  Text(
                                    '2500',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700
            
                                    ),
                                  ),
            
                                ],
                              ),
            
                              kGap30,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Image count',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
            
                                  Text(
                                    '0%',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
            
                                ],
                              ),
            
                              kGap10,
            
                              LinearProgressIndicator(
                                value: 0, // Progress percentage (0%)
                                backgroundColor: Colors.white.withOpacity(0.4),
                                color: Colors.blue,
                                minHeight: 13,
                                borderRadius: BorderRadius.circular(15),
                              ),
            
                              kGap10,
            
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
            
                                  Text(
                                    '20',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700
            
                                    ),
                                  ),
            
                                ],
                              ),
                            ],
                          ),
                        ),
            
                        kGap35,
            
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: OutlinedButton(
                            onPressed: (){},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.white, width: 2),
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 114),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            child: Text(
                              'Upgrade NOW',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                              )
                            ),
                        )
            
            
            
                       
            
            
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
