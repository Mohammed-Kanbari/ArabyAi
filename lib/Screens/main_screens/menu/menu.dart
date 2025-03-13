import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_araby_ai/Screens/main_screens/HomePage.dart';
import 'package:my_araby_ai/Screens/starting_screens/login_page.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/Screens/main_screens/menu/payment.dart';
import 'package:my_araby_ai/Screens/main_screens/menu/plans.dart';
import 'package:my_araby_ai/Screens/main_screens/menu/profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_araby_ai/providers/user_provider.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
    _ensureUserData();
  }

  Future<void> _ensureUserData() async {
    UserProvider provider = context.read<UserProvider>();
    if (provider.username == null || provider.firebaseUid != auth.FirebaseAuth.instance.currentUser?.uid) {
      await provider.fetchUserData();
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
                    child: Consumer<UserProvider>(
                        builder: (context, provider, child) {
                      // Use UserProvider data or fallback to defaults
                      String username = provider.username ?? 'User';
                      String phone = provider.phone ?? '+971 123456789';
                      String? profilePictureUrl = provider.profilePictureUrl;

                      String displayPhone = phone;
                      String countryCode = '';
                      if (phone.startsWith('+971')) {
                        countryCode = '+971';
                        displayPhone = phone.replaceFirst('+971', '');
                      } else if (phone.startsWith('+1')) {
                        countryCode = '+1';
                        displayPhone = phone.replaceFirst('+1', '');
                      } else if (phone.startsWith('+44')) {
                        countryCode = '+44';
                        displayPhone = phone.replaceFirst('+44', '');
                      }

                      return Column(
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
                                          image: profilePictureUrl != null &&
                                                  File(profilePictureUrl)
                                                      .existsSync()
                                              ? FileImage(
                                                  File(profilePictureUrl))
                                              : const AssetImage(
                                                      'assets/images/Rectangle.png')
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.all(
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
                                  '$countryCode $displayPhone',
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
                              buildMenuItem('Home', 'assets/images/home.png',
                                  () {
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
                                  'assets/images/arcticons_simplecamera.png',
                                  () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Plans()),
                                );
                              }),
                              buildMenuItem(
                                  'Payment', 'assets/images/dollar.png', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Payment()),
                                );
                              }),
                              Divider(),
                              buildMenuItem('Settings',
                                  'assets/images/settings.png', () {}),
                              buildMenuItem('Languages',
                                  'assets/images/planet.png', () {}),
                              buildMenuItem('Log out',
                                  'assets/images/bx_log-out-circle.png',
                                  () async {
                                // Clear user data (e.g., authentication token) stored in shared preferences
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs
                                    .clear(); // This clears all the stored data

                                // Sign out from Firebase Auth
                                await FirebaseAuth.instance.signOut();

                                // Also sign out from Google (if the user logged in via Google)
                                GoogleSignIn googleSignIn = GoogleSignIn();
                                await googleSignIn.signOut();

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
                      );
                    }),
                  ),
                ),
              ])),
        ));
  }

  Widget buildMenuItem(String title, String imagePath, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(imagePath, width: 24.w, height: 24.h),
      title:
          Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp)),
      onTap: onTap,
    );
  }


}
