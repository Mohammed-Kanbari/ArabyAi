import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/HomePage.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/menu/payment.dart';
import 'package:my_araby_ai/menu/plans.dart';
import 'package:my_araby_ai/menu/profile.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu',
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
                    ))
              ],
            ),
            kGap25,
            Center(
              child: Column(
                children: [
                  Container(
                    width:
                        108.0, // Add border width (e.g., 4.0 x 2) to width and height
                    height: 108.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF4042E2),
                          const Color(0xFFDB63C3),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(116, 116)),
                    ),
                    child: Center(
                      child: Container(
                        width: 100.0, // Original container size
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: AssetImage('assets/images/Rectangle.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(108, 108)),
                        ),
                      ),
                    ),
                  ),
                  kGap10,
                  Text(
                    'Username',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                  kGap5,
                  Text(
                    '+971 123456789',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400),
                  ),
                  kGap10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 115.0),
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/images/person.png',
                              width: 20,
                              height: 20,
                            ),
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
            kGap30,
            buildMenuItem('Home', 'assets/images/home.png', () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            }),
            buildMenuItem('History', 'assets/images/time-clock.png', () {}),
            buildMenuItem('Saved', 'assets/images/heart.png', () {}),
            buildMenuItem('Plans', 'assets/images/arcticons_simplecamera.png',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Plans()),
              );
            }),
            buildMenuItem('Payment', 'assets/images/dollar.png', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Payment()),
              );
            }),
            Divider(),
            buildMenuItem('Settings', 'assets/images/settings.png', () {}),
            buildMenuItem('Languages', 'assets/images/planet.png', () {}),
            buildMenuItem(
                'Log out', 'assets/images/bx_log-out-circle.png', () {}),
          ],
        ),
      )),
    );
  }

  Widget buildMenuItem(String title, String imagePath, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        imagePath,
        width: 24,
        height: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
