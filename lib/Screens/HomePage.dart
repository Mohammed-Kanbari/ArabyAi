import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/type_of_contents/Email%20Page/E-mails_page.dart';
import 'package:my_araby_ai/Screens/type_of_contents/SocailM%20Page/sm_main.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/Screens//type_of_contents/images_page.dart';
import 'package:my_araby_ai/widgets/topBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_araby_ai/widgets/type_of_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of image paths
  List<String> imagePaths = [
    'assets/home_imgs/1.png',
    'assets/home_imgs/2.png',
    'assets/home_imgs/3.png',
    'assets/home_imgs/4.png',
    'assets/home_imgs/5.png',
    'assets/home_imgs/6.png',
    'assets/home_imgs/7.png',
    'assets/home_imgs/8.png',
    'assets/home_imgs/9.png',
  ];

  // List of texts
  List<String> texts = [
    'Image',
    'Social Media',
    'E-mails',
    'Ads',
    'Messeges',
    'SEO',
    'E-commerce',
    'Long Documents',
    'Others',
  ];

  // List of pages you want to navigate to
  List<Widget> pages = [
    Image_Page(), // for index 0
    SmMain(), // for index 1
    Email_Page()
    // Add more pages here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: LayoutBuilder(builder: (context, constraints) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
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
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello Username,',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    'How may I help you today?',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Image spanning both lines
                            Flexible(
                              flex: 1,
                              child: Align(
                                child: Image.asset(
                                  'assets/images/robot.png',
                                  width: 104.w,
                                  height: 120.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          'Choose the type of content you would like to create for now :',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                    child: GridView.builder(
                      itemCount: 9,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 25),
                      itemBuilder: (BuildContext context, int index) {
                        // Ensure we pass the correct page to navigate to based on the index
                        return ImageTextButton(
                          imagePath:
                              imagePaths[index], // Pass image path dynamically
                          text: texts[index], // Pass text dynamically
                          onTap: () {
                            // Navigate to the corresponding page based on the index
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => pages[index %
                                    pages.length], // Use modulo for wrapping
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Wrap(
                  //   direction: Axis.horizontal,
                  //   spacing: -15, // Horizontal spacing
                  //   runSpacing: -15,

                  //   children: [
                  //     IconButton(
                  //         onPressed: () {
                  //           Navigator.push(context,
                  //            MaterialPageRoute(builder: (context) => Image_Page()));
                  //         },
                  //         icon: Image.asset('assets/home_imgs/1.png',
                  //             width: 135.w, height: 135.h)),

                  //     IconButton(
                  //         onPressed: () {
                  //           Navigator.push(context,
                  //            MaterialPageRoute(builder: (context) => SmMain()));
                  //         },
                  //         icon: Image.asset('assets/home_imgs/2.png',
                  //             width: 135.w, height: 135.h)),

                  //     IconButton(
                  //         onPressed: () {
                  //           Navigator.push(context,
                  //            MaterialPageRoute(builder: (context) => Email_Page()));
                  //         },
                  //         icon: Image.asset('assets/home_imgs/3.png',
                  //             width: 135.w, height: 135.h)),

                  //     IconButton(
                  //         onPressed: () {},
                  //         icon: Image.asset('assets/home_imgs/4.png',
                  //             width: 135.w, height: 135.h)),

                  //     IconButton(
                  //         onPressed: () {},
                  //         icon: Image.asset('assets/home_imgs/5.png',
                  //             width: 135.w, height: 135.h)),

                  //     IconButton(
                  //         onPressed: () {},
                  //         icon: Image.asset('assets/home_imgs/6.png',
                  //             width: 135.w, height: 135.h)),

                  //     IconButton(
                  //         onPressed: () {},
                  //         icon: Image.asset('assets/home_imgs/7.png',
                  //             width: 135.w, height: 135.h)),

                  //     IconButton(
                  //         onPressed: () {},
                  //         icon: Image.asset('assets/home_imgs/8.png',
                  //             width: 135.w, height: 135.h)),

                  //     IconButton(
                  //         onPressed: () {},
                  //         icon: Image.asset('assets/home_imgs/9.png',
                  //             width: 135.w, height: 135.h)),
                  //   ],
                  // ),

                  kGap20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 380.w,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(188, 102, 211, 254),
                                const Color.fromARGB(255, 216, 115, 196)
                              ],
                              stops: [
                                0.03,
                                1
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 24),
                                child: Text(
                                  'Trial Plan',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, top: 8),
                                child: Image.asset(
                                  'assets/images/rocket.png',
                                  width: 100.w,
                                  height: 100.h,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Word count',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Text(
                                      '20%',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                kGap10,
                                LinearProgressIndicator(
                                  value: 0.2, // Progress percentage (20%)
                                  backgroundColor:
                                      Colors.white.withOpacity(0.4),
                                  color: Colors.blue,
                                  minHeight: 13,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                kGap10,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '500',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '2500',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                kGap30,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Image count',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Text(
                                      '0%',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                kGap10,
                                LinearProgressIndicator(
                                  value: 0, // Progress percentage (0%)
                                  backgroundColor:
                                      Colors.white.withOpacity(0.4),
                                  color: Colors.blue,
                                  minHeight: 13,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                kGap10,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '20',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          kGap35,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        side: BorderSide(
                                            color: Colors.white, width: 2.w),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: Text(
                                      'Upgrade NOW',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    )),
                              ),
                            ),
                          ),
                          kGap25,
                        ],
                      ),
                    ),
                  ),
                  kGap15,
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
