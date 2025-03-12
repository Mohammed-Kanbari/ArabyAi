import 'package:flutter/material.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/Screens/side_screens/imrpve_email.dart';
import 'package:my_araby_ai/widgets/email_type.dart';
import 'package:my_araby_ai/widgets/topBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Email_Page extends StatefulWidget {
  const Email_Page({super.key});

  @override
  State<Email_Page> createState() => _Email_PageState();
}

class _Email_PageState extends State<Email_Page> {
  List<String> imagePaths = [
    'assets/email_imgs/10.png',
    'assets/email_imgs/11.png',
    'assets/email_imgs/12.png',
    'assets/email_imgs/13.png',
    'assets/email_imgs/14.png',
    'assets/email_imgs/12.png',
  ];

  // List of texts
  List<String> texts = [
    'E-mail',
    'Cold Email',
    'Email Subject',
    'E-mail Milstone',
    'Promotional E-mail',
    'Improve Your E-mail',
  ];

  // List of pages you want to navigate to
  List<Widget?> pages = [
    null,
    null,
    null,
    null,
    null,
    ImrpveEmail()
    // Add more pages here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What do you want to create ?',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      ),
                      kGap25,

                      GridView.builder(
                        itemCount: 6,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 25),
                        itemBuilder: (BuildContext context, int index) {
                          // Ensure we pass the correct page to navigate to based on the index
                          return EmailType(
                            imagePath: imagePaths[
                                index], // Pass image path dynamically
                            text: texts[index], // Pass text dynamically
                            onTap: () {
                              // Navigate to the corresponding page based on the index
                              if (pages[index] != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => pages[
                                        index]!, // Use modulo for wrapping
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                      // Wrap(
                      //   direction: Axis.horizontal,
                      //   spacing: 25, // Horizontal spacing
                      //   runSpacing: 25, // Vertical spacing
                      //   children: [
                      //     GridItem(
                      //       text: 'E-mail',
                      //       imageAsset: 'assets/images/image_10.png',
                      //       onTap: () {},
                      //     ),
                      //     GridItem(
                      //       text: 'Cold Email',
                      //       imageAsset: 'assets/images/image_11.png',
                      //       onTap: () {},
                      //     ),
                      //     GridItem(
                      //       text: 'Email \nSubject',
                      //       imageAsset: 'assets/images/image_12.png',
                      //       onTap: () {},
                      //     ),
                      //     GridItem(
                      //       text: 'E-mail Milestone',
                      //       imageAsset: 'assets/images/image_13.png',
                      //       onTap: () {},
                      //     ),
                      //     GridItem(
                      //       text: 'Promotional \nE-mail',
                      //       imageAsset: 'assets/images/image_14.png',
                      //       onTap: () {},
                      //     ),
                      //     GridItem(
                      //       text: 'Improve Your \nE-mail',
                      //       imageAsset: 'assets/images/image_12.png',
                      //       onTap: () {
                      //         Navigator.push(context,
                      //          MaterialPageRoute(builder: (context) => ImrpveEmail()));
                      //       },
                      //     ),
                      //   ],
                      // ),
                    ],
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
