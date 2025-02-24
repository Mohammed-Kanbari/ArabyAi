import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/HomePage.dart';
import 'package:my_araby_ai/Screens/login_page.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/Screens/menu/payment.dart';
import 'package:my_araby_ai/Screens/menu/plans.dart';
import 'package:my_araby_ai/Screens/menu/profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
    _getUsername(); // Fetch username when the widget initializes
  }

String username = ""; // Default value

  // This function saves the username in Firestore
Future<void> _getUsername() async {
    try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String uid = FirebaseAuth.instance.currentUser!.uid; // Get the current user's UID

    // Fetch the document for the current user using their UID
    DocumentSnapshot userDoc = await firestore.collection('Users').doc(uid).get();

    if (userDoc.exists) {
      // Get the username from the document
      setState(() {
        username = userDoc['name'] ?? "User"; // Assuming the field is 'name'
      });
    } else {
      setState(() {
        username = "User"; // Default username if document doesn't exist
      });
    }
  } catch (e) {
    print("Error fetching username: $e");
    setState(() {
      username = "User"; // Default username if there's an error
    });
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 10.0,
                right: 20.0,
              ),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menu',
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
                        ))
                  ],
                ),
                kGap25,
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Container(
                                width: 108.0.w,
                                height: 108.0.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF4042E2),
                                      const Color(0xFFDB63C3),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(116, 116)),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 100.0.w, // Original container size
                                    height: 100.0.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff7c94b6),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/Rectangle.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(108, 108)),
                                    ),
                                  ),
                                ),
                              ),
                              kGap10,
                              Text(
                                username,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                              kGap5,
                              Text(
                                '+971 123456789',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400),
                              ),
                              kGap10,
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()),
                                  );
                                },
                                child: Container(
                                  width: 152.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32),
                                      border: Border.all(width: 0.5)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/person.png',
                                        width: 20.w,
                                        height: 20.h,
                                      ),
                                      Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          children: [
                            buildMenuItem('Home', 'assets/images/home.png', () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);
                            }),
                            buildMenuItem('History',
                                'assets/images/time-clock.png', () {}),
                            buildMenuItem(
                                'Saved', 'assets/images/heart.png', () {}),
                            buildMenuItem('Plans',
                                'assets/images/arcticons_simplecamera.png', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Plans()),
                              );
                            }),
                            buildMenuItem('Payment', 'assets/images/dollar.png',
                                () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Payment()),
                              );
                            }),
                            Divider(),
                            buildMenuItem('Settings',
                                'assets/images/settings.png', () {}),
                            buildMenuItem(
                                'Languages', 'assets/images/planet.png', () {}),
                            buildMenuItem('Log out',
                                'assets/images/bx_log-out-circle.png',
                                () async {
                              // Clear user data (e.g., authentication token) stored in shared preferences
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs
                                  .clear(); // This clears all the stored data

                              // Navigate back to the login screen
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (route) =>
                                    false, // This prevents the user from going back to the menu
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
        ));
  }

  Widget buildMenuItem(String title, String imagePath, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        imagePath,
        width: 24.w,
        height: 24.h,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16.sp,
        ),
      ),
      onTap: onTap,
    );
  }
}
