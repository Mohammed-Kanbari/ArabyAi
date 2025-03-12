import 'package:flutter/material.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/Screens/side_screens/sm_facebook.dart';

import 'package:my_araby_ai/widgets/social_type.dart';
import 'package:my_araby_ai/widgets/topBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmMain extends StatefulWidget {
  const SmMain({super.key});

  @override
  State<SmMain> createState() => _SmMainState();
}

class _SmMainState extends State<SmMain> {
  List<String> imagePaths = [
    'assets/social_imgs/face.png',
    'assets/social_imgs/inst.png',
    'assets/social_imgs/linked.png',
    'assets/social_imgs/soc.png',
    'assets/social_imgs/tik.png',
    'assets/social_imgs/tweet.png',
  ];

  // List of texts
  List<String> texts = [
    'Facebook Status',
    'Instgram Caption',
    'LinkedIn Post',
    'Social Media Profile Bio',
    'Tiktok Video Idea',
    'Tweet',
  ];

  // List of pages you want to navigate to
  List<Widget?> pages = [
    SmFacebook(),
    null,
    null,
    null,
    null,
    null,
    
    // Add more pages here
  ];



  @override
  Widget build(BuildContext context) {
            final screenWidth = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                          return SocialType(
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
                    //       text: 'Facebook \nStatus',
                    //       imageAsset: 'assets/images/facebook.png',
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => SmFacebook()));
                    //       },
                    //     ),
                    //     GridItem(
                    //       text: 'Instgram \nCaption',
                    //       imageAsset: 'assets/images/insta.png',
                    //       onTap: () {},
                    //     ),
                    //     GridItem(
                    //       text: 'LinkedIn \nPost',
                    //       imageAsset: 'assets/images/linkedin.png',
                    //       onTap: () {},
                    //     ),
                    //     GridItem(
                    //       text: 'Social Media \nProfile Bio',
                    //       imageAsset: 'assets/images/social.png',
                    //       onTap: () {},
                    //     ),
                    //     GridItem(
                    //       text: 'Tiktok Video \nIdea',
                    //       imageAsset: 'assets/images/tiktok.png',
                    //       onTap: () {},
                    //     ),
                    //     GridItem(
                    //       text: 'Tweet \n',
                    //       imageAsset: 'assets/images/twitter.png',
                    //       onTap: () {},
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
