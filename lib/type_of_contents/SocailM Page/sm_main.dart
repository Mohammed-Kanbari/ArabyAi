import 'package:flutter/material.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/type_of_contents/SocailM%20Page/sm_facebook.dart';
import 'package:my_araby_ai/widgets/grid_items.dart';
import 'package:my_araby_ai/widgets/topBar.dart';



class SmMain extends StatefulWidget {
  const SmMain({super.key});

  @override
  State<SmMain> createState() => _SmMainState();
}

class _SmMainState extends State<SmMain> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    kGap25,
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 25, // Horizontal spacing
                      runSpacing: 25, // Vertical spacing
                      children: [
                        GridItem(
                          text: 'Facebook \nStatus',
                          imageAsset: 'assets/images/facebook.png',
                          onTap: () {
                            Navigator.push(context,
                             MaterialPageRoute(builder: (context) => SmFacebook()));
                          },
                        ),
                        GridItem(
                          text: 'Instgram \nCaption',
                          imageAsset: 'assets/images/insta.png',
                          onTap: () {},
                        ),
                        GridItem(
                          text: 'LinkedIn \nPost',
                          imageAsset: 'assets/images/linkedin.png',
                          onTap: () {},
                        ),
                        GridItem(
                          text: 'Social Media \nProfile Bio',
                          imageAsset: 'assets/images/social.png',
                          onTap: () {},
                        ),
                        GridItem(
                          text: 'Tiktok Video \nIdea',
                          imageAsset: 'assets/images/tiktok.png',
                          onTap: () {},
                        ),
                        GridItem(
                          text: 'Tweet \n',
                          imageAsset: 'assets/images/twitter.png',
                          onTap: () {
                          },
                        ),
                      ],
                    ),
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