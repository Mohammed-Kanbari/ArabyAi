import 'package:flutter/material.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/Screens/type_of_contents/Email%20Page/imrpve_email.dart';
import 'package:my_araby_ai/widgets/grid_items.dart';
import 'package:my_araby_ai/widgets/topBar.dart';

class Email_Page extends StatefulWidget {
  const Email_Page({super.key});

  @override
  State<Email_Page> createState() => _Email_PageState();
}

class _Email_PageState extends State<Email_Page> {
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
                          text: 'E-mail',
                          imageAsset: 'assets/images/image_10.png',
                          onTap: () {},
                        ),
                        GridItem(
                          text: 'Cold Email',
                          imageAsset: 'assets/images/image_11.png',
                          onTap: () {},
                        ),
                        GridItem(
                          text: 'Email \nSubject',
                          imageAsset: 'assets/images/image_12.png',
                          onTap: () {},
                        ),
                        GridItem(
                          text: 'E-mail Milestone',
                          imageAsset: 'assets/images/image_13.png',
                          onTap: () {},
                        ),
                        GridItem(
                          text: 'Promotional \nE-mail',
                          imageAsset: 'assets/images/image_14.png',
                          onTap: () {},
                        ),
                        GridItem(
                          text: 'Improve Your \nE-mail',
                          imageAsset: 'assets/images/image_12.png',
                          onTap: () {
                            Navigator.push(context,
                             MaterialPageRoute(builder: (context) => ImrpveEmail()));
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
