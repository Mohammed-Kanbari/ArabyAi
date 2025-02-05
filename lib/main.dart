import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/HomePage.dart';
import 'package:my_araby_ai/Screens/araby_splash_screen.dart';
import 'package:my_araby_ai/Screens/signup_page.dart';


void main() {
  runApp(const AnApp());
}


class AnApp extends StatelessWidget {
  const AnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Araby_SC(),
    );
  }
}



/*
1- Sign in/login Authentication
2- Sign up and connecting to the firebase
3- saving the credintials (email, pass, username) to a DB
4- verification email
5- In the Home Page, 'Hello (username)' must show the name of the user that he chose

6- Image page functionalites
7- Social media page functionalities
8- Emails page functionaliteis
9- Search bar function
10- notification function
12- Editing profile page functionalites

13- Log out

//learn clean code
//learn responsive design

*/
